-module(frequency).
-export([start/0, stop/0, allocate/0, deallocate/1]).
-export([init/0]).

%% These are the start functions used to crate and
%% initialize the server.

start() ->
  register(frequency, spawn(frequency, init, [])).
  
init() ->
  Frequencies = {get_frequencies(), []},
  loop(Frequencies).
  
% Hard Coded
get_frequencies() -> [10, 11, 12, 13, 14, 15].

%% The client Functions

stop() 			-> call(stop).
allocate()		-> call(allocate).
deallocate(Freq)-> io:format("Calling deallocate~n",[]), call({deallocate, Freq}).

%% We hide all message passing and the message
%% protocol in a functional interface.

call(Message) ->
  frequency ! {request, self(), Message},
  receive
    {reply, Reply} -> Reply
  end.
  
%% The Main Loop

loop(Frequencies) ->
  receive 
    {request, Pid, allocate} ->
	  {NewFrequencies, Reply} = allocate(Frequencies, Pid),
	  reply(Pid, Reply),
	  loop(NewFrequencies);
	{request, Pid2, {deallocate, Freq}} ->
	  {NewFrequencies, Reply} = deallocate(Frequencies, Freq, Pid2),
	  reply(Pid2, Reply),
	  loop(NewFrequencies);
	{request, Pid, stop} ->
	  case Frequencies of
	  {_Free, []} -> reply(Pid, ok);
	  _ -> reply(Pid, {error, not_all_freqs_deallocated}),
	       loop(Frequencies)
	  end
  end.
  
reply(Pid, Reply) ->
  Pid ! {reply, Reply}.
  
%% The Internal Help Functions used to allocate and
%% deallocate frequencies.

allocate({[], Allocated}, _Pid) ->
  {{[], Allocated}, {error, no_frequency}};
allocate({[Freq|Free], Allocated}, Pid) ->
  NoOfFreqsToPid = length(match(Pid, Allocated)),
  if NoOfFreqsToPid < 3 ->
    {{Free, [{Freq, Pid}| Allocated]}, {ok, Freq}};
  true -> {{[Freq|Free], Allocated},{error, max_no_of_freq_reached}}
  end.
  
deallocate({Free, Allocated}, Freq, Pid) ->
  Response = lists:keysearch(Freq, 1, Allocated),
  case Response of
    {value, {Freq, Pid}} ->
	    NewAllocated = lists:keydelete(Freq, 1, Allocated),
		{{[Freq|Free], NewAllocated}, {ok, removed}};
	{value, {Freq, _OtherPid}} ->
			{{Free, Allocated}, {error, not_owner}};
	_ -> {{Free, Allocated}, {error, not_found}}
  end.
  
match(_Value, []) ->
  [];
match(Value, DbName) ->
  [{H, OldValue}|Tail] = DbName,
  case OldValue of
    Value -> [H | match(Value, Tail)];
	_ -> match(Value, Tail)
end.

