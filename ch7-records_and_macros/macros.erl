-module(macros).
%% Simple macro definition:
-define(TIMEOUT, 1000).

%% Use of macro:
receive
  after ?TIMEOUT ->
	   ok
end

-define(FUNC,X).
-define(TION,+X).

double(X) ->
    ?FUNC?TION. %% Will change into X + X.

%% Macros with parameters:
-define(Multiple(X,Y), X rem Y == 0).

testFun(Z,W) when ?Multiple(Z,W) ->
    true;
testFun(Z,W) -> false.


%% Print macro's definition as string:
-define(VALUE(Call), io:format("~p = ~p~n", [??Call,Call])).
% test1() -> ?VALUE(length([1,2,3])).
%printout: "length ( [ 1 , 2 , 3 ] )" = 3

%Predefined macros:
?MODULE
?MODULE_STRING
?FILE
?LINE
?MACHINE

%% Conditional compilation:
-undef(Flag).
-ifdef(Flag).
  %% Do if Flag is defined
-endif.
-ifndef(Flag).
  %% Do if Flag not defined
-else.
  % do if else
-endif.

% You can compile with flag debug set:
% c(Module,[{d,debug}]).

%% Compiling with parameter 'P' will output file ending with .P
%% That is source code after resolving macros.
