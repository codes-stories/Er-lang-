%%=========================================================
%% Module: basic_process_learning
%% Purpose: Learn Erlang Processes and Message Passing

%$ WHat is a process in Erlang?
%$ A process in Erlang is a lightweight, concurrent execution unit that can run independently and communicate with other processes via message passing. Each process has its own state and mailbox for receiving messages.
%Definition in hinglish: "Erlang mein process ek lightweight, concurrent execution unit hai jo independently chal sakta hai aur doosre processes ke saath message passing ke through communicate kar sakta hai. Har process ka apna state aur mailbox hota hai jisme wo messages receive karta hai."    
%%=========================================================

-module(basic_process_learning).

%% Exported functions (entry points for testing and demo)
-export([
    main/0,
    process_basics/0,
    send_receive_basics/0,
    stateful_process/0,
    links_and_monitors/0,
    ping_pong_example/0
]).

%%=========================================================
%% 1. PROCESS BASICS
%%=========================================================

process_basics() ->
    %% self() returns current process id (Pid)
    Parent = self(),

    %% spawn starts a new lightweight Erlang process
    Child = spawn(fun() ->
        Parent ! {child_started, self()}
    end),

    receive
        {child_started, ChildPid} ->
            io:format("Parent: ~p Child: ~p~n", [Parent, ChildPid])
    after 1000 ->
        io:format("Timed out waiting for child start message~n")
    end,

    %% Process metadata helper
    IsAlive = erlang:is_process_alive(Child),
    io:format("Child alive after work: ~p~n", [IsAlive]),
    ok.

%%=========================================================
%% 2. SEND / RECEIVE BASICS
%%=========================================================

send_receive_basics() ->
    Parent = self(),

    Worker = spawn(fun() ->
        receive
            {hello, From, Name} ->
                From ! {reply, io_lib:format("Hello, ~s", [Name])};
            _Other ->
                From = Parent,
                From ! {error, unknown_message}
        after 2000 ->
            Parent ! {error, timeout}
        end
    end),

    %% Send a message using ! operator
    Worker ! {hello, Parent, "Learner"},

    receive
        {reply, Text} ->
            io:format("Worker replied: ~s~n", [Text]);
        {error, Reason} ->
            io:format("Worker error: ~p~n", [Reason])
    after 1000 ->
        io:format("Timed out waiting for worker reply~n")
    end,
    ok.

%%=========================================================
%% 3. STATEFUL PROCESS (LOOP WITH RECURSION)
%%=========================================================

stateful_process() ->
    Counter = start_counter(),

    Counter ! {inc, 5},
    Counter ! {inc, 2},
    Counter ! {get, self()},

    receive
        {count, Value1} -> io:format("Counter value: ~p~n", [Value1])
    after 1000 ->
        io:format("Timed out waiting for first count~n")
    end,

    Counter ! {reset},
    Counter ! {get, self()},
    receive
        {count, Value2} -> io:format("Counter after reset: ~p~n", [Value2])
    after 1000 ->
        io:format("Timed out waiting for second count~n")
    end,

    Counter ! stop,
    ok.

start_counter() ->
    spawn(fun() -> counter_loop(0) end).

counter_loop(Value) ->
    receive
        {inc, N} when is_integer(N) ->
            counter_loop(Value + N);
        {get, From} ->
            From ! {count, Value},
            counter_loop(Value);
        {reset} ->
            counter_loop(0);
        stop ->
            ok;
        _ ->
            counter_loop(Value)
    end.

%%=========================================================
%% 4. LINKS AND MONITORS
%%=========================================================

links_and_monitors() ->
    process_flag(trap_exit, true),

    %% Link example: parent receives {'EXIT', Pid, Reason}
    Linked = spawn_link(fun() ->
        exit(simulated_failure)
    end),

    receive
        {'EXIT', Linked, Reason1} ->
            io:format("Linked process exited with reason: ~p~n", [Reason1])
    after 1000 ->
        io:format("No EXIT received from linked process~n")
    end,

    %% Monitor example: monitor message is {'DOWN', Ref, process, Pid, Reason}
    Monitored = spawn(fun() ->
        exit(normal)
    end),
    Ref = erlang:monitor(process, Monitored),

    receive
        {'DOWN', Ref, process, Monitored, Reason2} ->
            io:format("Monitored process down with reason: ~p~n", [Reason2])
    after 1000 ->
        io:format("No DOWN received from monitored process~n")
    end,
    ok.

%%=========================================================
%% 5. PRACTICAL PING-PONG EXAMPLE
%%=========================================================

ping_pong_example() ->
    Parent = self(),

    PongPid = spawn(fun() -> pong_loop() end),
    PingPid = spawn(fun() -> ping_loop(PongPid, Parent, 3) end),

    receive
        {done, PingPid} ->
            io:format("Ping-pong finished successfully~n")
    after 2000 ->
        io:format("Timed out waiting for ping-pong completion~n")
    end,
    ok.

ping_loop(_PongPid, Parent, 0) ->
    Parent ! {done, self()};
ping_loop(PongPid, Parent, N) ->
    PongPid ! {ping, self(), N},
    receive
        {pong, N} ->
            io:format("Received pong for round ~p~n", [N]),
            ping_loop(PongPid, Parent, N - 1)
    after 1000 ->
        io:format("Ping timed out at round ~p~n", [N]),
        Parent ! {done, self()}
    end.

pong_loop() ->
    receive
        {ping, From, N} ->
            io:format("Pong received ping round ~p~n", [N]),
            From ! {pong, N},
            pong_loop()
    after 3000 ->
        ok
    end.

%% main/0 runner in recommended learning order
main() ->
    io:format("~n--- Processes Learning: Beginner Walkthrough ---~n"),
    process_basics(),
    send_receive_basics(),
    stateful_process(),
    links_and_monitors(),
    ping_pong_example(),
    io:format("--- End of walkthrough ---~n"),
    ok.