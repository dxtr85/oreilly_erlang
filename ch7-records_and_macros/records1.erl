-module(records1).
-export([birthday/1, joe/0, showPerson/1]).

-record(person, {name,age=0,phone}).

birthday(#person{age=Age} = P) ->
    P#person{age = Age + 1}.

joe() ->
    #person{name = "Joe", age = 21, phone = "333-4444"}.

showPerson(#person{age=Age,name=Name,phone=Phone} = P)->
    io:format("Name: ~p, age: ~p, phone: ~p~n", 
              [Name, Age, Phone]).
