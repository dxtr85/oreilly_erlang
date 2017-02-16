-module('exc7_1').
-export([birthday/1, joe/0, showPerson/1]).

-record(person, {name,age=0,phone, address}).

birthday(#person{age=Age} = P) ->
    P#person{age = Age + 1}.

joe() ->
    #person{name = "Joe", age = 21, phone = "333-4444", address = "Koziegłowy 13"}.

showPerson(#person{age=Age,name=Name,phone=Phone, address=Adr} = _P)->
    io:format("Name: ~p, age: ~p, phone: ~p, address: ~p~n", 
              [Name, Age, Phone, Adr]).
