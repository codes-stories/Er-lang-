% Erlang basics examples: data types, control flow, functions,
% macros, atoms, binaries, tuples, lists, comprehensions, maps, records.

-module(basic01).
-export([main/0, run/0, day1/0, day2/0]).

-define(MAX, 100).

-record(person, {name, age}).

main() ->
    run().

run() ->
    io:format("~n--- basic01: run all chapters ---~n"),
    io:format("Chapter Day 1: Data types and guards~n"),
    day1(),
    io:format("~nChapter Day 2: Lists, Tuples and pattern matching~n"),
    day2(),
    io:format("--- done ---~n"),
    ok.

%% Chapter Day 1: Data types and conditional/guard statements
day1() ->
    % Basic data types
    I = 42,
    F = 3.14,
    A = some_atom,
    S = "string",          % string (list of integers)
    B = <<"bin">>,         % binary
    T = {tag, 1},
    L = [1,2,3],
    M = #{k => v},
    io:format("Integer: ~p, Float: ~p, Atom: ~p~n", [I, F, A]),
    io:format("String: ~s, Binary: ~p~n", [S, B]),
    io:format("Tuple: ~p, List: ~p, Map: ~p~n", [T, L, M]),

    % Guards: demonstrate case with guards and function clauses with guards
    Value = -5,
    case Value of
        N when N < 0 -> io:format("Value is negative: ~p~n", [N]);
        0 -> io:format("Value is zero~n");
        N when N > 0 -> io:format("Value is positive: ~p~n", [N])
    end,

    io:format("abs_guard(~p)=~p~n", [Value, abs_guard(Value)]),
    ok.

abs_guard(N) when N < 0 -> -N;
abs_guard(N) when N >= 0 -> N.

%% Chapter Day 2: Lists and Tuples with pattern matching
day2() ->
    % Tuple pattern matching
    Tup = {person, "Alice", 30},
    {person, Name, Age} = Tup,
    io:format("Tuple matched: name=~s age=~p~n", [Name, Age]),

    % List pattern matching: head/tail
    List = [10,20,30,40],
    [H|T] = List,
    io:format("Head: ~p, Tail: ~p~n", [H, T]),

    % Matching specific shapes
    case List of
        [First,Second|Rest] -> io:format("First=~p Second=~p Rest=~p~n", [First, Second, Rest]);
        [] -> io:format("Empty list~n")
    end,

    % Function clauses using pattern matching
    io:format("sum_list([1,2,3])=~p~n", [sum_list([1,2,3])]),
    io:format("pair_to_tuple([a,b])=~p~n", [pair_to_tuple([a,b])]),
    ok.

sum_list([]) -> 0;
sum_list([H|T]) -> H + sum_list(T).

pair_to_tuple([A,B]) -> {A,B}.

%% Basic data types and literals
types_examples() ->
    Int = 42,
    Float = 3.14,
    Atom = hello,
    Str = "hello",        % strings are lists of integers in Erlang
    Bin = <<"hello">>,    % binary
    io:format("Int: ~p, Float: ~p~n", [Int, Float]),
    io:format("Atom: ~p, String: ~s, Binary: ~p~n", [Atom, Str, Bin]),
    ok.

%% Conditional statements: if, case and guards
control_flow() ->
    X = 7,
    % if with guard clauses (no explicit "else" keyword)
    if X < 5 -> io:format("X < 5~n");
       X == 5 -> io:format("X == 5~n");
       true -> io:format("X > 5 (~p)~n", [X])
    end,

    % case expression with pattern matching and guards
    case {ok, 2} of
        {ok, N} when N > 0 -> io:format("Positive: ~p~n", [N]);
        {error, Reason} -> io:format("Error: ~p~n", [Reason])
    end,
    ok.

%% Functions, pattern matching, recursion and multiple clauses
funcs_examples() ->
    io:format("sum(1,2)=~p~n", [sum(1,2)]),
    io:format("fib(10)=~p~n", [fib(10)]),
    io:format("greet(english)=~s~n", [greet(english)]),
    io:format("greet(spanish)=~s~n", [greet(spanish)]),
    io:format("greet(other)=~s~n", [greet(other)]),
    ok.

sum(A, B) -> A + B.

fib(0) -> 0;
fib(1) -> 1;
fib(N) when N > 1 -> fib(N-1) + fib(N-2).

greet(english) -> "Hello";
greet(spanish) -> "Hola";
greet(_) -> "Hi".

%% Tuples, lists, maps and records
data_structures() ->
    Tup = {ok, 123},
    List = [1,2,3],
    Nested = [a, {b, [1,2]}, <<"bin">>],
    Map = #{name => "Alice", age => 30},
    Person = #person{name="Bob", age=40},
    io:format("Tuple: ~p, List: ~p~n", [Tup, List]),
    io:format("Nested: ~p~n", [Nested]),
    io:format("Map: ~p, Record: ~p~n", [Map, Person]),
    ok.

%% List comprehensions and generators
comprehensions() ->
    L = [1,2,3,4,5],
    Evens = [X || X <- L, X rem 2 == 0],
    Doubled = [X*2 || X <- L],
    Pairs = [{X,Y} || X <- [1,2], Y <- [a,b]],
    io:format("Evens: ~p, Doubled: ~p, Pairs: ~p~n", [Evens, Doubled, Pairs]),
    ok.

%% Macros
macros_example() ->
    Val = ?MAX,
    io:format("Macro MAX: ~p~n", [Val]),
    ok.