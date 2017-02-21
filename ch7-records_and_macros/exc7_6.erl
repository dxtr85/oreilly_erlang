%% To compile this module with flag show set use:
%% 'c(exc7_6, [{d,show}]). from interpreter.'

-module(exc7_6).
-export([test/1]).

-ifdef(show).
  -define(SHOW_EVAL(Call), io:format("~p = ~p~n", [??Call, Call])).
-else.
  -define(SHOW_EVAL(Call), io:format("~p~n",[Call])).
-endif.

-define(CALLS(ModFunc),  (put( ModFunc, (case get(ModFunc) of
undefined -> 1; N -> N + 1 end)))). 
test(Args) ->
    ?SHOW_EVAL(Args). % Used like this will show "Args" when flag is on.


