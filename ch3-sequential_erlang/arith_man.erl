-module(arith_man).
-export([parse/1]).

parse(List) -> parser(List,{n,n,n},[]).

parser([$(|Rest], Result, SupOp) ->
  parser(Rest, {n, n, n}, [Result | SupOp]);
parser([$(|Rest], {minus, A1}, SupOp) ->
  parser(Rest, {n, n, n}, [{minus, A1} | SupOp]);
parser([N|Rest],  Result, SupOp) when N >= 48, N =< 57 ->
  case Result of
    {n, n, n} -> parser(Rest, {n, {num, N-48}, n}, SupOp);
	{Op, A1, n} -> parser(Rest, {Op, A1, {num, N-48}}, SupOp);
	{minus, n} -> parser(Rest, {minus, {num, N-48}}, SupOp)
  end;
parser([$)|Rest], Result, [Prev|SupOp]) ->
  case Prev of
    {n, n, n} -> parser(Rest, {n, Result, n}, SupOp);
	{minus, n} -> parser(Rest, {minus, Result}, SupOp);
	{Op, A1, n} -> parser(Rest, {Op, A1, Result}, SupOp)
  end;
parser([$\+|Rest], {Op, A1, A2}, SupOp) ->
      parser(Rest, {add, A1, A2}, SupOp);
parser([$-|Rest],  {Op, A1, A2}, SupOp) ->
      parser(Rest, {sub, A1, A2}, SupOp);
parser([$*|Rest],  {Op, A1, A2}, SupOp) ->
      parser(Rest, {mult, A1, A2}, SupOp);
parser([$/|Rest],  {Op, A1, A2}, SupOp) ->
      parser(Rest, {divi, A1, A2}, SupOp);
parser([$~|Rest],  {Op, A1, A2}, SupOp) ->
      parser(Rest, {minus, A1}, SupOp);
parser([],                Result, []) -> Result;
parser(Rest, Result, []) -> parser(Rest, {n, Result, n}, []).

