-module(workspace).
%% This is how we define a record:
-record(person, {name,age,phone}).

%% Construction of a object from record:
%#person{name="Joe",
%        age=21,
%        phone="999-9999"}
% or in this order(no difference):
% #person{age=21,
%        name="Joe",
%        phone="999-9999"}

%defaults to some attributes of a record:
-record(new_person, {name, age=0, phone=""}).
%We can create object from record without all attributes:
Person = #person{name="Fred"}
%% This is how we create a new object from existing one,
%% changing only one attribute:
NewPerson = Person#person{age=30,name="Kuba"}

birthday1(P) ->
    P#person{age = P#person.age + 1}. % Return new object
%% from existing one, changing only it's one attribute

birthday2(#person{age=Age} = P) ->
    P#person{age = Age + 1}. % More readable version of 
%% previous method.

% This is a very special method that will work only for "Joe"s
joesBirthday(#person{age=Age, name="Joe"} = P) ->
    P#person{age = Age + 1}.



%% in shell we can read records like following:
% rr(records1).

%% We define a record in shell like:
% rd(name, {first, surname}).

%% We list all records with
% rl().

% Records are just tuples, but we should NEVER use them as tuples!!!
% If we do, we will loose one abstraction layer which is allowing us
% to easy upgrade a record in only few places and not reviewing entire
% project after slightest change in record's structure.

% 'E' option during compilation shows how the code looks like after 
% compiler transormed records.

% There is BIF record_info which can give you information about a record:
record_info(size, person). %% Number of attributes + 1 (name)
record_info(fields, person).
is_record(Term, person) %% Returns true or false, depending if is record.

-include("filename.hrl"). %% allows to define records in a single file and 
%% import them if needed.
