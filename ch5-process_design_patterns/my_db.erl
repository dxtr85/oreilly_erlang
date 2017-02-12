-module(my_db).
-export([start/0, stop/0, write/2, delete/1, read/1, match/1, loop/1]).

start() ->
  case whereis(my_db) of
    undefined ->
      register(my_db, spawn(my_db, loop, [db:new()])), ok;
	_ ->
	  io:format("my_db already started."), ok
  end.
  
stop() ->
  case whereis(my_db) of
    undefined ->
      io:format("my_db not registered!"), ok;
	_ ->
	  my_db ! stop, ok
  end.
  
write(Key, Element) ->
  my_db ! {write, Key, Element}, ok.
  
delete(Key) ->
  my_db ! {delete, Key}.
  
read(Key) ->
  my_db ! {read, Key, self()},
  receive Response -> Response end.

match(Value) ->
  my_db ! {match, Value, self()},
  receive Response -> Response end.
  
loop(DB) ->
  receive
    {write, Key, Element} -> 	NewDB = db:write(Key, Element, DB),
								loop(NewDB);
	{delete, Key} ->	NewDB = db:delete(Key, DB),
								loop(NewDB);
	{read, Key, Pid} -> Response = db:read(Key, DB),
								Pid ! Response,
								loop(DB);
	{match, Value, Pid} -> Response = db:match(Value, DB),
								Pid ! Response,
								loop(DB);
	stop -> ok
end.

