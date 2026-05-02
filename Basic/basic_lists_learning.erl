%%=========================================================
%% Module: basic_lists_learning
%% Purpose: Learn Erlang Lists (Basics → Advanced)
%%=========================================================

-module(basic_lists_learning).
% Beginner-friendly list learning with extra topics
% Chapters:
%  - main/0: run all list-related examples in order
%  - basic_lists/0: creating lists, head/tail
%  - list_operations/0: concat, subtract, cons
%  - list_functions/0: useful functions from lists module
%  - list_comprehensions/0: comprehensions and patterns
%  - pattern_examples/0: tuple/list pattern matching basics
%  - recursion_examples/0: recursion patterns for lists
%  - atoms_binaries/0: quick atom vs binary notes
%  - io_examples/0: simple I/O formatting for beginners
% (duplicate module declaration removed)

%% Exported functions (entry points for testing and demo)
-export([
    main/0,
    basic_lists/0,
    list_operations/0,
    list_functions/0,
    list_comprehensions/0,
    pattern_examples/0,
    recursion_examples/0,
    atoms_binaries/0,
    io_examples/0
]).

%%=========================================================
%% 1. BASIC LISTS
%%=========================================================

basic_lists() ->
    %% Creating lists
    Empty = [],
    Numbers = [1, 2, 3, 4, 5],
    Mixed = [1, hello, 3.14, {tuple, 1}],

    %% Head and Tail
    [Head | Tail] = Numbers,

    % Print values with friendly labels
    io:format("Empty list = ~p~n", [Empty]),
    io:format("Numbers list = ~p~n", [Numbers]),
    io:format("Mixed list (different types) = ~p~n", [Mixed]),
    io:format("Head of Numbers = ~p, Tail = ~p~n", [Head, Tail]).

%%=========================================================
%% 2. LIST OPERATIONS
%%=========================================================

list_operations() ->
    List1 = [1, 2, 3],
    List2 = [4, 5, 6],

    %% Concatenation
    Combined = List1 ++ List2,

    %% Subtraction (removes elements of List2 from List1)
    Subtracted = Combined -- [2, 5],

    %% Adding element (cons operator)
    NewList = [0 | List1],

    %% Pattern matching
    [H | T] = Combined,

    io:format("Combined: ~p~n", [Combined]),
    io:format("Subtracted: ~p~n", [Subtracted]),
    io:format("New List: ~p~n", [NewList]),
    io:format("Head: ~p Tail: ~p~n", [H, T]).

%% Short notes for beginners:
%  - Use ++ to join lists, but it's O(n) on the left operand.
%  - Use [X|List] to prepend efficiently.

%%=========================================================
%% 3. LIST BUILT-IN FUNCTIONS (lists module)
%%=========================================================

list_functions() ->
    List = [1, 2, 3, 4, 5],

    %% Length
    Len = length(List),

    %% Reverse
    Rev = lists:reverse(List),

    %% Member check
    IsMember = lists:member(3, List),

    %% Map (apply function to each element)
    Squared = lists:map(fun(X) -> X * X end, List),

    %% Filter (keep elements satisfying condition)
    Even = lists:filter(fun(X) -> X rem 2 == 0 end, List),

    %% Fold (reduce list to single value)
    Sum = lists:foldl(fun(X, Acc) -> X + Acc end, 0, List),

    %% Sort
    Sorted = lists:sort([5, 3, 1, 4, 2]),

    %% Append
    Appended = lists:append([List, [6,7]]),

    %% Flatten nested lists
    Flattened = lists:flatten([1, [2, [3, 4]], 5]),

    io:format("Length: ~p~n", [Len]),
    io:format("Reverse: ~p~n", [Rev]),
    io:format("Member 3: ~p~n", [IsMember]),
    io:format("Squared: ~p~n", [Squared]),
    io:format("Even: ~p~n", [Even]),
    io:format("Sum: ~p~n", [Sum]),
    io:format("Sorted: ~p~n", [Sorted]),
    io:format("Appended: ~p~n", [Appended]),
    io:format("Flattened: ~p~n", [Flattened]).

% Tip: prefer lists:map/filter for readable transformations.

%%=========================================================
%% 4. LIST COMPREHENSIONS
%%=========================================================

list_comprehensions() ->
    List = [1, 2, 3, 4, 5],

    %% Basic comprehension
    Squares = [X * X || X <- List],

    %% With condition
    EvenSquares = [X * X || X <- List, X rem 2 == 0],

    %% Multiple generators
    Pairs = [{X, Y} || X <- [1,2], Y <- [a,b]],

    %% Pattern matching inside comprehension
    Tuples = [{ok, 1}, {error, 2}, {ok, 3}],
    OkValues = [V || {ok, V} <- Tuples],

    %% Using function inside comprehension
    Doubled = [double(X) || X <- List],

    io:format("Squares: ~p~n", [Squares]),
    io:format("Even Squares: ~p~n", [EvenSquares]),
    io:format("Pairs: ~p~n", [Pairs]),
    io:format("Ok Values: ~p~n", [OkValues]),
    io:format("Doubled: ~p~n", [Doubled]).

% Comprehensions are concise for transformation + filtering.

%%==========================
%% Pattern matching examples
%%==========================
pattern_examples() ->
    % Tuple matching: extract by structure
    Tup = {person, "Alice", 30},
    {person, Name, Age} = Tup,
    io:format("Tuple matched -> Name: ~s, Age: ~p~n", [Name, Age]),

    % List matching: head and tail
    L = [10,20,30],
    [H|Tail] = L,
    io:format("List head = ~p, tail = ~p~n", [H, Tail]),

    % Match exact shape
    case L of
        [First,Second,Third] -> io:format("Three elements: ~p,~p,~p~n", [First,Second,Third]);
        _ -> io:format("Other shape~n")
    end,
    ok.

%%==========================
%% Recursion basics for lists
%%==========================
recursion_examples() ->
    % Sum of a list via recursion
    S = sum_list([1,2,3,4]),
    io:format("sum_list([1,2,3,4]) = ~p~n", [S]),

    % Factorial as simple recursion example
    F = factorial(5),
    io:format("factorial(5) = ~p~n", [F]),
    ok.

sum_list([]) -> 0;
sum_list([H|T]) -> H + sum_list(T).

factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N-1).

%%==========================
%% Atoms vs Binaries (short)
%%==========================
atoms_binaries() ->
    A = hello, % atom, efficient symbolic constant
    B = <<"hello">>, % binary, useful for binaries/IO
    io:format("Atom: ~p, Binary: ~p~n", [A, B]),
    ok.

%%==========================
%% Simple I/O examples
%%==========================
io_examples() ->
    Name = "Learner",
    io:format("Hello, ~s! This prints a string.~n", [Name]),
    io:format("Show debug with ~p for any term: ~p~n", [Name, {ok, Name}]),
    ok.

%% main/0 runner to walk through sections in a beginner-friendly order
main() ->
    io:format("~n--- Lists Learning: Beginner Walkthrough ---~n"),
    basic_lists(),
    pattern_examples(),
    list_operations(),
    list_functions(),
    recursion_examples(),
    list_comprehensions(),
    atoms_binaries(),
    io_examples(),
    io:format("--- End of walkthrough ---~n"),
    ok.

%% Helper function
double(X) ->
    X * 2.