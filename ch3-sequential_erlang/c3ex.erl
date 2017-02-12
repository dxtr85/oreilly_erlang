-module(c3ex).
-export([sum/1, sum/2, create/1, reverse_create/1, print_ints/1, print_even_ints/1, filter/2, reverse/1, cat/1, flat/1, qsort/1, msort/1]).

sum(0) -> 0;
sum(N) when N > 0 -> N + sum(N-1).

sum(N,M) when N =< M -> sum(M)-sum(N-1).


create(N) when N>0 -> lists:reverse(create_priv(N)).
create_priv(0) -> [];
create_priv(N) -> [N | create_priv(N-1)].

reverse_create(0) -> [];
reverse_create(N) when N>0 -> [N | reverse_create(N-1)].

print_numbers(A,Max,OnlyEven) when A=<Max ->
  case OnlyEven of
	true -> 
	  if 
	    A rem 2 == 0 -> io:format("Number:~p~n", [A]);
		true -> true
	  end;
    false -> io:format("Number:~p~n", [A])
  end,
  print_numbers(A+1,Max,OnlyEven);
print_numbers(_A, _B,_OnlyEven) -> true.

print_ints(N) when N>0 -> print_numbers(1,N,false).
print_even_ints(N) when N>0 -> print_numbers(1,N,true).

filter([], _Int) -> [];
filter(List, Int) -> 
  [H | Tail] = List,
  if H =< Int -> [H | filter(Tail, Int)];
     H > Int -> filter(Tail, Int)
  end.
  
reverse([]) -> [];
reverse(List) ->
  %[H| T] = List,
  %[reverse(T) | H].
  reverse_acc(List, []).
  
reverse_acc([H | Tail], Acc) ->
  reverse_acc(Tail, [H|Acc]);
reverse_acc([], Acc) -> Acc.

cat([Head|Tail]) -> Head ++ cat(Tail);
cat([]) -> [].

flat(List) ->
  case List of 
    [[Head|Tail]| Tail2] -> flat([Head|Tail]) ++ flat(Tail2);
	[[] | Tail] -> flat(Tail);
	[Head|Tail] -> [Head] ++ flat(Tail);
    [] -> []
  end.
  
qsort([]) -> [];
qsort([H|T]) -> qsort([Y || Y<-T,Y=<H])++[H]++qsort([Y || Y<-T,Y>H]).

msort([]) -> [];
msort([A]) -> [A];
msort(List) -> 
  {LList, RList} = split_in_halves(List),
  Left = msort(LList),
  Right = msort(RList),
  merge(Left, Right).
  
merge([], Right) -> Right;
merge(Left, []) -> Left;
merge(Left, Right) ->
  [LH | LT] = Left,
  [RH | RT] = Right,
  case LH >= RH of
    true -> [RH | merge(Left, RT)];
	false -> [LH | merge(LT, Right)]
  end.

% split_in_halves : list -> {list,list}
%  return two lists of lengths differing with at most one
sih_loop(Front, Slow, []) -> {lists:reverse(Front), Slow};
sih_loop(Front, Slow, Fast) ->
    Y = tl(Fast),
    if
        Y == [] -> { lists:reverse([hd(Slow) | Front]), tl(Slow) };
        true    -> sih_loop( [hd(Slow) | Front],
                             tl(Slow), tl(tl(Fast)))
    end.
 
split_in_halves(List) ->
sih_loop([], List, List).

