-module(exc7_3).
-export([new/0, destroy/1, write/3, delete/2, read/2, match/2]).
-include("records.hrl").

new() -> [].

destroy(_DbName) -> true.

write(Key, Value, DbName) ->
  case read(Key, DbName) of
    {error,instance} ->
      true;
    {ok, _OldValue} ->
      delete(Key, DbName)
  end,
  [#data{key=Key,value=Value}|DbName].
  
delete(Key, DbName) ->
  remove_element(Key, DbName).

read(_D, []) ->
  {error,instance};
read(Key, DbName) ->
  [#data{key=K, value=Value}|Tail] = DbName,
  case K of
    Key -> {ok, Value};
	_ -> read(Key, Tail)
  end.
  
match(_V, []) ->
  [];
match(Value, DbName) ->
  [#data{key=K, value=OldValue}|Tail] = DbName,
  case OldValue of
    Value -> [K | match(Value, Tail)];
	_ -> match(Value, Tail)
  end.

remove_element(_D, []) ->
  true;
remove_element(Key, List) ->
  [#data{key=K,value=Value}|Tail] = List,
  case K of
    Key -> Tail;
	_ -> [{K, Value}|remove_element(Key, Tail)]
end.

