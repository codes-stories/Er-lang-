%%=========================================================
%% Module: tuples_learning
%% Purpose: Learn Erlang Tuples (Basics → Advanced)
%%=========================================================

-module(basic_tuples_learning).

%% Exported functions
-export([
    basic_tuples/0,
    tuple_operations/0,
    tuple_functions/0,
    tuple_patterns/0
]).

%%=========================================================
%% 1. BASIC TUPLES
%%=========================================================

basic_tuples() ->
    %% Creating tuples
    Empty = {},
    Person = {john, 25, developer},
    Mixed = {1, hello, 3.14, {nested, tuple}},

    %% Accessing elements (1-based index)
    First = element(1, Person),
    Second = element(2, Person),

    io:format("Empty: ~p~n", [Empty]),
    io:format("Person: ~p~n", [Person]),
    io:format("Mixed: ~p~n", [Mixed]),
    io:format("First: ~p Second: ~p~n", [First, Second]).

%%=========================================================
%% 2. TUPLE OPERATIONS
%%=========================================================

tuple_operations() ->
    Tuple = {a, b, c},

    %% Get size of tuple
    Size = tuple_size(Tuple),

    %% Update element (returns NEW tuple)
    Updated = setelement(2, Tuple, x),

    %% Convert list to tuple
    FromList = list_to_tuple([1,2,3]),

    %% Convert tuple to list
    ToList = tuple_to_list(Tuple),

    io:format("Original: ~p~n", [Tuple]),
    io:format("Size: ~p~n", [Size]),
    io:format("Updated: ~p~n", [Updated]),
    io:format("From List: ~p~n", [FromList]),
    io:format("To List: ~p~n", [ToList]).

%%=========================================================
%% 3. TUPLE FUNCTIONS (COMMON USAGE)
%%=========================================================

tuple_functions() ->
    %% Tuples are often used with tagged values
    Success = {ok, 100},
    Error = {error, "failed"},

    %% Extract values using pattern matching
    {ok, Value} = Success,

    %% Safe handling using case
    Result1 = handle_result(Success),
    Result2 = handle_result(Error),

    io:format("Extracted Value: ~p~n", [Value]),
    io:format("Result1: ~p~n", [Result1]),
    io:format("Result2: ~p~n", [Result2]).

handle_result({ok, Value}) ->
    {success, Value};

handle_result({error, Reason}) ->
    {failure, Reason}.

%%=========================================================
%% 4. TUPLE PATTERN MATCHING
%%=========================================================

tuple_patterns() ->
    %% Basic pattern matching
    {Name, Age, Role} = {alice, 30, engineer},

    %% Nested tuple matching
    {user, {Id, Status}} = {user, {101, active}},

    %% Ignoring values using '_'
    {_, OnlyValue} = {ignore, 999},

    %% Matching in function call
    Result = describe_person({bob, 40}),

    io:format("Name: ~p Age: ~p Role: ~p~n", [Name, Age, Role]),
    io:format("Id: ~p Status: ~p~n", [Id, Status]),
    io:format("OnlyValue: ~p~n", [OnlyValue]),
    io:format("Description: ~p~n", [Result]).

describe_person({Name, Age}) when Age >= 18 ->
    {adult, Name};

describe_person({Name, Age}) ->
    {minor, Name}.