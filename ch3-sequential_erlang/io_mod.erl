-module(io_mod).
-export([in_out/0]).

in_out() ->
    List = [2,3,math:pi()],
    Sum = lists:sum(List),
    io:format("Hello, world!",[]),
    %io:format("The sum of ~w is ~w.~n", [[2,3,4],ioExs:sum([2,3,4])]),
    io:format("The sum of ~w is ~w.~n", [List, Sum]),
    io:format("The sum of ~W is ~w.~n", [List,3,Sum]),
    io:format("The sum of ~W is ~f.~n", [List,3,Sum]),
    io:format("The SUM of ~W is ~.2f.~n.~n", [List,3,Sum]).
    %io:format("~40p~n", [{apply, io, format, ["the sum of ~W is ~.2f.~n", [[2,3,math:pi()],3,ioExs:sum([2,3,math:pi()])]]}]).
    
    
