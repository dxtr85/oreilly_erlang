-module(recursion).
-export([bump/1, average/1, even/1, member/2, merge/2]).

bump([]) ->
    [];
bump([Head|Tail]) -> [Head +1 | bump(Tail)].

bump2(List) ->
    bump_acc(List, []).

bump_acc([], Acc) ->
    reverse(Acc);
bump_acc([H|T], Acc) ->
    bump_acc(T, [H+1 | Acc]).
average([]) -> 0;
average(List) -> sum(List) / len(List).

average2([]) ->
    0;
average2(List) -> average_acc(List, 0, 0).
average_acc([], Sum, Length) ->
    Sum / Length;
average_acc([H|T], Sum, Length) ->
    average_acc(T, H+Sum,1+Length).

sum([]) ->
    0;
sum([H|T]) -> H + sum(T).

sum2(List) ->
    sum_acc(List, 0).

sum_acc([], Sum) ->
    Sum;
sum_acc([H|T], Sum) ->
    sum_acc(T, H+Sum).

len([]) ->
    0;
len([_|T]) -> 1 + len(T).

even([]) ->
    [];
even([H|T]) when H rem 2 == 0 -> [H | even(T)];
even([_|T]) -> even(T).

member(_,[]) ->
    false;
member(H, [H|_]) -> true;
member(H,[_|T]) -> member(H,T).

reverse(List) ->
    reverse_acc(List, []).
reverse_acc([], Acc) ->
    Acc;
reverse_acc([H|T], Acc) ->
    reverse_acc(T, [H|Acc]).

merge(Xs,Ys) ->
    lists:reverse(mergeL(Xs,Ys,[])).
mergeL([X|Xs], Ys,Zs)->
    mergeR(Xs,Ys,[X|Zs]);
mergeL([],[],Zs) ->
    Zs.
mergeR(Xs,[Y|Ys],Zs)->
    mergeL(Xs,Ys,[Y|Zs]);
mergeR([],[],Zs) ->
    Zs.


