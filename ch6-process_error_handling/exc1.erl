-module(exc1).
-export([print/1, start/0, stop/0, loop/0]).

start() ->
  case whereis(echo) of
    undefined ->
      register(echo, spawn_link(exc1, loop, []));
	_ ->
	  io:format("echo already started.")
  end.
  
stop() ->
  io:format("Terminaling abnormally!\n"),
  exit(self(), abnormal).
  
print(Term) ->
 case whereis(echo) of
    undefined ->
      io:format("echo not registered!");
	_ ->
	  echo ! {print, Term},
	  ok
  end.
 
loop() ->
  receive
    {print, Term} -> io:format("~p~n", [Term]),
	                 loop();
	stop -> true
end.
