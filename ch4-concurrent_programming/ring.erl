-module(ring).
-export([start/3, create_ring/4]).

start(M, N, Message) -> create_ring(self(), M, N, Message).

create_ring(Pid, 0, N, Message) ->
  Pid ! {send_msg, N, Message},
  loop(Pid);
  
create_ring(Pid, M, N, Message) ->
  %io:format("Spawn ~w~n", [M]),
  loop(spawn(ring, create_ring, [Pid, M-1, N, Message])).
  
loop(Pid) ->
  receive
    {send_msg, N, Message} -> send_msg(Pid, N, Message),
							  loop(Pid);
	close -> %io:format("Close received~n",[]),
             Pid ! close, ok;
	{PidRcv, Message} ->
	  Self = self(),
	  case {PidRcv, Message} of
	    {Self, Message} -> loop(Pid);
		{_Pid, Message} -> Pid ! {PidRcv, Message}, loop(Pid)
	  end
	end.

send_msg(Pid, 0, _Message) ->
  %io:format("Sending close ~n",[]),
  Pid ! close,
  ok;
send_msg(Pid, N, Message) ->
  %io:format("Sending msg ~w~n", [N]),
  Pid ! {self(), Message},
send_msg(Pid, N-1, Message).

