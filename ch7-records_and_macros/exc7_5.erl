-module(exc7_5).
-export([sum_tree/1,max_val/1,is_tree_ordered/1,ordered_insert_tree/2]).
-include("records.hrl").

sum_tree(undefined) ->
    0;
sum_tree(#bnode{value=V,left=L,right=R}) ->
    V+sum_tree(L)+sum_tree(R).

max_val(undefined) ->
    0;
max_val(#bnode{value=V,left=L,right=R}) ->
    LeftMax = max_val(L),
    RightMax= max_val(R),
    erlang:max(erlang:max(LeftMax,RightMax),V).

is_tree_ordered(#bnode{value=V,left=L,right=R})->
    is_tree_ordered(V,R) and is_tree_ordered(L,V).
    
is_tree_ordered(undefined, _N) ->
    true;
is_tree_ordered(_N, undefined) ->
    true;
is_tree_ordered(#bnode{value=V1,left=L1,right=R1}, 
                V2) ->
    case V1 =< V2 of 
      false-> false;
      true-> is_tree_ordered(V1,R1) and is_tree_ordered(L1,V1)
    end;
is_tree_ordered(V1, #bnode{value=V2,left=L2,right=R2}) ->
    case V1 =< V2 of 
      false-> false;
      true-> is_tree_ordered(V2,R2) and is_tree_ordered(L2,V2)
    end.

ordered_insert_tree(Value, undefined) ->
    #bnode{value=Value};
ordered_insert_tree(Value, #bnode{value=V,left=L,right=R}) ->
    case Value =< V of
      true -> NewLeft = ordered_insert_tree(Value, L),
              #bnode{value=V,left=NewLeft,right=R};
	false-> NewRight = ordered_insert_tree(Value,R),
		#bnode{value=V,left=L,right=NewRight}
    end.
	    
