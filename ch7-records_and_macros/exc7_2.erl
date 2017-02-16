-module('exc7_2').
-export([foobar/1, joe/0]).

-record(person, {name,age=0,phone, address}).

foobar(#person{age=Age} = P) when is_record(P, person), P#person.name == "Joe"->
    P#person{age = Age + 1};
foobar(_P) ->
    false.

joe() ->
    #person{name = "Joe", age = 21, phone = "333-4444", address = "Koziegłowy 13"}.

