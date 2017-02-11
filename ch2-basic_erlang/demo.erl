-module(demo).
-export([double/1]).

%A comment.

double(Value) ->
    times(Value, 2).
times(X,Y) ->
    X*Y.

