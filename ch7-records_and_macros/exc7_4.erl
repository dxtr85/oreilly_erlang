-module(exc7_4).
-include("shapes.hrl").
-export([area/1,perimeter/1]).

area(#circle{radius=R}) ->
    math:pi()*R*R;
area(#rectangle{width=W,height=H}) ->
    W*H;
area(#triangle{side_a=A,side_b=B,side_c=C}=T) ->
    P = perimeter(T),
    math:sqrt(P*(P-A)*(P-B)*(P-C)).

perimeter(#circle{radius=R}) ->
    2*math:pi()*R;
perimeter(#rectangle{width=W,height=H}) ->
    2*(H+W);
perimeter(#triangle{side_a=A,side_b=B,side_c=C}) ->
    A+B+C.
