-module(exc2).
-export([start/0, stop/0]).
-export([wait/0, signal/0]).
-export([init/0]).

start() ->
  register(mutex, spawn(?MODULE, init, [])).

stop() ->
    mutex ! stop.

wait() ->
    mutex ! {wait, self()},
    receive ok -> ok end.

signal() ->
    mutex ! {signal, self()}, ok.

init() ->
    process_flag(trap_exit, true),
    free().

free() ->
    receive
      {wait , Pid} ->
%            try
%              link(Pid)
               Ref = erlang:monitor(process, Pid),
%            catch _Class:Err ->
%              io:format("Caught ~p~n",[Err]),
%              free()
%            end,
              Pid ! ok,
              busy(Pid, Ref);
      stop ->
            terminate()
    end.
%% This is when processes are linked
busy(Pid) ->
    receive
      {signal, Pid} ->
	    free();
      {'EXIT', Pid, _Reason} ->
            free()
    end.
%% This is when processes are monitored
busy(Pid, Ref) ->
    receive
      {signal, Pid} ->
	    free();
	{'DOWN', Ref, process, Pid, _Reason} ->
            free()
    end.


terminate() ->
    receive
      {wait, Pid} ->
	    exit(Pid, kill),
	    terminate()
    after 0 ->
	    ok
end.
