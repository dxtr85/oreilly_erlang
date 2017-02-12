-module(io_handler).
-export([init/1, terminate/1, handle_event/2]).

init(Count) -> Count.

terminate(Count) -> {count, Count}.

handle_event({raise_alarm, Id, Alarm}, Count) ->
  print(alarm, Id, Alarm, Count),
  Count+1;
handle_event({clear_alarm, Id, Alarm}, Count) ->
  print(clear, Id, Alarm, Count),
  Count+1;
handle_event(_Event, Count) ->
  Count.
  
print(Type, Id, Alarm, Count) ->
  Date = fmt(date()), Time = fmt(time()),
  io:format("#~w,~s,~s,~w,~w,~p,~n", [Count, Date, Time, Type, Id, Alarm]).
  
fmt({AInt, BInt, CInt}) ->
  Astr = pad(integer_to_list(AInt)),
  Bstr = pad(integer_to_list(BInt)),
  Cstr = pad(integer_to_list(CInt)),
  [Astr,$:,Bstr,$:,Cstr].
  
pad([M1]) -> [$0,M1];
pad(Other) -> Other.

