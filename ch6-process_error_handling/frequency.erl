-module(frequency).
-export([start/0, stop/0, allocate/0, deallocate/1]).
-export([init/0]).

%% These are the start functions used to create and
%% initialize the server.

start() ->
  register(frequency, spawn(frequency, init, [])).

init() ->
    process_flag(trap_exit, true),
    Freq = {get_frequencies(), []},
    loop(Freq).

%% Hard coded
get_frequencies() ->
  [10, 11, 12, 13, 14, 15].

%% The client functions

stop() ->
  call(stop).

allocate() ->
  call(allocate).

deallocate(Freq) ->
    call({deallocate, Freq}).

%% We hide all message passing and the message
%% protocol in a functional interface.
call(Message) ->
    frequency ! {request, self(), Message},
    receive
      {reply, Reply } -> Reply
    end.

reply(Pid, Message) ->
  Pid ! {reply, Message}.

loop(Freq) ->
  receive
    {request, Pid, allocate} ->
      {NewFreq, Reply} = allocate(Freq, Pid),
      reply(Pid, Reply),
      loop(NewFreq);
    {request, Pid, {deallocate, Fr}} ->
	  NewFreq = deallocate(Freq, Fr),
	  reply(Pid, ok),
	  loop(NewFreq);
    {'EXIT', Pid, _Reason} ->
	  NewFreq = exited(Freq, Pid),
	  loop(NewFreq);
    {request, Pid, stop} ->
      reply(Pid, ok)
    end.

allocate({[], Allocated}, _Pid) ->
    {{[], Allocated}, {error, no_frequencies}};
allocate({[Freq|Frequencies], Allocated}, Pid) ->
    link(Pid),
    {{Frequencies, [{Freq,Pid}|Allocated]}, {ok, Freq}}.

deallocate({Free, Allocated}, Freq) ->
    {value,{Freq,Pid}} = lists:keysearch(Freq,1,Allocated),
    unlink(Pid),
    NewAllocated = lists:keydelete(Freq,1,Allocated),
    {[Freq|Free], NewAllocated}.

exited({Free, Allocated}, Pid) ->
    case lists:keysearch(Pid,2,Allocated) of
      {value,{Freq, Pid}} ->
	    NewAllocated = lists:keydelete(Freq,1,Allocated),
	    {[Freq|Free],NewAllocated};
      false ->
        {Free,Allocated}
end.
