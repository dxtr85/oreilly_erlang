-module(db).
-export([new/0, destroy/1, write/3, delete/2, read/2, match/2]).

new() -> [].

destroy(_DbName) -> true.

write(Key, Value, DbName) ->
  case read(Key, DbName) of
    {error,instance} ->
      true;
    {ok, _OldValue} ->
      delete(Key, DbName)
  end,
  [{Key, Value}|DbName].
  
delete(Key, DbName) ->
  remove_element(Key, DbName).

read(_Key, []) ->
  {error,instance};
read(Key, DbName) ->
  [{H, Value}|Tail] = DbName,
  case H of
    Key -> {ok, Value};
	_ -> read(Key, Tail)
  end.
  
match(_Value, []) ->
  [];
match(Value, DbName) ->
  [{H, OldValue}|Tail] = DbName,
  case OldValue of
    Value -> [H | match(Value, Tail)];
	_ -> match(Value, Tail)
  end.

remove_element(_Element, []) ->
  true;
remove_element(Element, List) ->
  [{H,Value}|Tail] = List,
  case H of
    Element -> Tail;
	_ -> [{H, Value}|remove_element(Element, Tail)]
end.

