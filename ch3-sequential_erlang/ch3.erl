-module(ch3).
-export([is_member/2, is_even/1, is_number/1, built_ins/0]).

is_member(Element, List) ->
    case lists:member(Element, List) of
      true ->
	    ok;
      false -> {error, unknown_element}
    end.

is_even(Int) when Int rem 2 == 0 ->
    true;
is_even(Int) when Int rem 2 == 1 ->
    false.

is_number(Num) when is_integer(Num) ->
    integer;
is_number(Num) when is_float(Num) ->
    float;
is_number(_Other) -> false.

built_ins() ->
    List = [one,two,three,four,five],
    hd(List),
    % one
    tl(List),
    % [two,three,four,five]
    length(List),
    % 5
    hd(tl(List)),
    % two
    Tuple = {1,2,3,4,5},
    tuple_size(Tuple),
    % 5
    element(2, Tuple),
    % 2
    setelement(3, Tuple, three),
    % {1,2,three,4,5}
    erlang:append_element(Tuple, 6),
    % {1,2,3,4,5,6}
    atom_to_list(monday),
    % "monday"
    %list_to_existing_atom("tuesday"),    
    % **exception error: bad argument...
    list_to_existing_atom("monday"),
    % monday
    list_to_tuple(tuple_to_list({one,two,three})),
    % {one,two,three}
    float(1),
    % 1.000000
    round(10.5),
    % 11
    trunc(10.5),
    % 10
    Module = examples,
    Function = even,
    Arguments = [10],
    %apply(Module, Function, Arguments).
    % true /** exception error: undefined function examples:even/1

