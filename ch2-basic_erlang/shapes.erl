-module(shapes).
-export([area/1]).

area({square, Edge}) ->
    Edge * Edge;
area({circle, R}) ->
    math:pi()*R*R;
area({rectangle, A, B}) ->
    A * B;
area(Other) ->
    {error, Other}.
