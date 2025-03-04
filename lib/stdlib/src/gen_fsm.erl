%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 1996-2023. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%
%% %CopyrightEnd%
%%
-module(gen_fsm).
-moduledoc """
Deprecated and replaced by gen_statem

Deprecated and replaced by `m:gen_statem`

[](){: #Migration-to-gen_statem }

## Migration to gen_statem

Here follows a simple example of turning a gen_fsm into a `m:gen_statem`. The
example comes from the previous Users Guide for `gen_fsm`

```erlang
-module(code_lock).
-define(NAME, code_lock).
%-define(BEFORE_REWRITE, true).

-ifdef(BEFORE_REWRITE).
-behaviour(gen_fsm).
-else.
-behaviour(gen_statem).
-endif.

-export([start_link/1, button/1, stop/0]).

-ifdef(BEFORE_REWRITE).
-export([init/1, locked/2, open/2, handle_sync_event/4, handle_event/3,
	 handle_info/3, terminate/3, code_change/4]).
-else.
-export([init/1, callback_mode/0, locked/3, open/3, terminate/3, code_change/4]).
%% Add callback__mode/0
%% Change arity of the state functions
%% Remove handle_info/3
-endif.

-ifdef(BEFORE_REWRITE).
start_link(Code) ->
    gen_fsm:start_link({local, ?NAME}, ?MODULE, Code, []).
-else.
start_link(Code) ->
    gen_statem:start_link({local,?NAME}, ?MODULE, Code, []).
-endif.

-ifdef(BEFORE_REWRITE).
button(Digit) ->
    gen_fsm:send_event(?NAME, {button, Digit}).
-else.
button(Digit) ->
    gen_statem:cast(?NAME, {button,Digit}).
    %% send_event is asynchronous and becomes a cast
-endif.

-ifdef(BEFORE_REWRITE).
stop() ->
    gen_fsm:sync_send_all_state_event(?NAME, stop).
-else.
stop() ->
    gen_statem:call(?NAME, stop).
    %% sync_send is synchronous and becomes call
    %% all_state is handled by callback code in gen_statem
-endif.

init(Code) ->
    do_lock(),
    Data = #{code => Code, remaining => Code},
    {ok, locked, Data}.

-ifdef(BEFORE_REWRITE).
-else.
callback_mode() ->
    state_functions.
%% state_functions mode is the mode most similar to
%% gen_fsm. There is also handle_event mode which is
%% a fairly different concept.
-endif.

-ifdef(BEFORE_REWRITE).
locked({button, Digit}, Data0) ->
    case analyze_lock(Digit, Data0) of
	{open = StateName, Data} ->
	    {next_state, StateName, Data, 10000};
	{StateName, Data} ->
	    {next_state, StateName, Data}
    end.
-else.
locked(cast, {button,Digit}, Data0) ->
    case analyze_lock(Digit, Data0) of
	{open = StateName, Data} ->
	    {next_state, StateName, Data, 10000};
	{StateName, Data} ->
	    {next_state, StateName, Data}
    end;
locked({call, From}, Msg, Data) ->
    handle_call(From, Msg, Data);
locked({info, Msg}, StateName, Data) ->
    handle_info(Msg, StateName, Data).
%% Arity differs
%% All state events are dispatched to handle_call and handle_info help
%% functions. If you want to handle a call or cast event specifically
%% for this state you would add a special clause for it above.
-endif.

-ifdef(BEFORE_REWRITE).
open(timeout, State) ->
     do_lock(),
    {next_state, locked, State};
open({button,_}, Data) ->
    {next_state, locked, Data}.
-else.
open(timeout, _, Data) ->
    do_lock(),
    {next_state, locked, Data};
open(cast, {button,_}, Data) ->
    {next_state, locked, Data};
open({call, From}, Msg, Data) ->
    handle_call(From, Msg, Data);
open(info, Msg, Data) ->
    handle_info(Msg, open, Data).
%% Arity differs
%% All state events are dispatched to handle_call and handle_info help
%% functions. If you want to handle a call or cast event specifically
%% for this state you would add a special clause for it above.
-endif.

-ifdef(BEFORE_REWRITE).
handle_sync_event(stop, _From, _StateName, Data) ->
    {stop, normal, ok, Data}.

handle_event(Event, StateName, Data) ->
    {stop, {shutdown, {unexpected, Event, StateName}}, Data}.

handle_info(Info, StateName, Data) ->
    {stop, {shutdown, {unexpected, Info, StateName}}, StateName, Data}.
-else.
-endif.

terminate(_Reason, State, _Data) ->
    State =/= locked andalso do_lock(),
    ok.
code_change(_Vsn, State, Data, _Extra) ->
    {ok, State, Data}.

%% Internal functions
-ifdef(BEFORE_REWRITE).
-else.
handle_call(From, stop, Data) ->
     {stop_and_reply, normal,  {reply, From, ok}, Data}.

handle_info(Info, StateName, Data) ->
    {stop, {shutdown, {unexpected, Info, StateName}}, StateName, Data}.
%% These are internal functions for handling all state events
%% and not behaviour callbacks as in gen_fsm
-endif.

analyze_lock(Digit, #{code := Code, remaining := Remaining} = Data) ->
     case Remaining of
         [Digit] ->
	     do_unlock(),
	     {open,  Data#{remaining := Code}};
         [Digit|Rest] -> % Incomplete
             {locked, Data#{remaining := Rest}};
         _Wrong ->
             {locked, Data#{remaining := Code}}
     end.

do_lock() ->
    io:format("Lock~n", []).
do_unlock() ->
    io:format("Unlock~n", []).
```
""".

%%%-----------------------------------------------------------------
%%%   
%%% This state machine is somewhat more pure than state_lib.  It is
%%% still based on State dispatching (one function per state), but
%%% allows a function handle_event to take care of events in all states.
%%% It's not that pure anymore :(  We also allow synchronized event sending.
%%%
%%% If the Parent process terminates the Module:terminate/2
%%% function is called.
%%%
%%% The user module should export:
%%%
%%%   init(Args)
%%%     ==> {ok, StateName, StateData}
%%%         {ok, StateName, StateData, Timeout}
%%%         ignore
%%%         {stop, Reason}
%%%
%%%   StateName(Msg, StateData)
%%%
%%%    ==> {next_state, NewStateName, NewStateData}
%%%        {next_state, NewStateName, NewStateData, Timeout}
%%%        {stop, Reason, NewStateData}
%%%              Reason = normal | shutdown | Term terminate(State) is called
%%%
%%%   StateName(Msg, From, StateData)
%%%
%%%    ==> {next_state, NewStateName, NewStateData}
%%%        {next_state, NewStateName, NewStateData, Timeout}
%%%        {reply, Reply, NewStateName, NewStateData}
%%%        {reply, Reply, NewStateName, NewStateData, Timeout}
%%%        {stop, Reason, NewStateData}
%%%              Reason = normal | shutdown | Term terminate(State) is called
%%%
%%%   handle_event(Msg, StateName, StateData)
%%%
%%%    ==> {next_state, NewStateName, NewStateData}
%%%        {next_state, NewStateName, NewStateData, Timeout}
%%%        {stop, Reason, Reply, NewStateData}
%%%        {stop, Reason, NewStateData}
%%%              Reason = normal | shutdown | Term terminate(State) is called
%%%
%%%   handle_sync_event(Msg, From, StateName, StateData)
%%%
%%%    ==> {next_state, NewStateName, NewStateData}
%%%        {next_state, NewStateName, NewStateData, Timeout}
%%%        {reply, Reply, NewStateName, NewStateData}
%%%        {reply, Reply, NewStateName, NewStateData, Timeout}
%%%        {stop, Reason, Reply, NewStateData}
%%%        {stop, Reason, NewStateData}
%%%              Reason = normal | shutdown | Term terminate(State) is called
%%%
%%%   handle_info(Info, StateName) (e.g. {'EXIT', P, R}, {nodedown, N}, ...
%%%
%%%    ==> {next_state, NewStateName, NewStateData}
%%%        {next_state, NewStateName, NewStateData, Timeout}
%%%        {stop, Reason, NewStateData}
%%%              Reason = normal | shutdown | Term terminate(State) is called
%%%
%%%   terminate(Reason, StateName, StateData) Let the user module clean up
%%%        always called when server terminates
%%%
%%%    ==> the return value is ignored
%%%
%%%
%%% The work flow (of the fsm) can be described as follows:
%%%
%%%   User module                           fsm
%%%   -----------                          -------
%%%     start              ----->             start
%%%     init               <-----              .
%%%
%%%                                           loop
%%%     StateName          <-----              .
%%%
%%%     handle_event       <-----              .
%%%
%%%     handle__sunc_event <-----              .
%%%
%%%     handle_info        <-----              .
%%%
%%%     terminate          <-----              .
%%%
%%%
%%% ---------------------------------------------------

-include("logger.hrl").

-export([start/3, start/4,
	 start_link/3, start_link/4,
	 stop/1, stop/3,
	 send_event/2, sync_send_event/2, sync_send_event/3,
	 send_all_state_event/2,
	 sync_send_all_state_event/2, sync_send_all_state_event/3,
	 reply/2,
	 start_timer/2,send_event_after/2,cancel_timer/1,
	 enter_loop/4, enter_loop/5, enter_loop/6, wake_hib/7]).

%% Internal exports
-export([init_it/6,
	 system_continue/3,
	 system_terminate/4,
	 system_code_change/4,
	 system_get_state/1,
	 system_replace_state/2,
	 format_status/2]).

%% logger callback
-export([format_log/1, format_log/2]).

-deprecated({'_','_', "use the 'gen_statem' module instead"}).

%%% ---------------------------------------------------
%%% Interface functions.
%%% ---------------------------------------------------

-callback init(Args :: term()) ->
    {ok, StateName :: atom(), StateData :: term()} |
    {ok, StateName :: atom(), StateData :: term(), timeout() | hibernate} |
    {stop, Reason :: term()} | ignore.
-callback handle_event(Event :: term(), StateName :: atom(),
                       StateData :: term()) ->
    {next_state, NextStateName :: atom(), NewStateData :: term()} |
    {next_state, NextStateName :: atom(), NewStateData :: term(),
     timeout() | hibernate} |
    {stop, Reason :: term(), NewStateData :: term()}.
-callback handle_sync_event(Event :: term(), From :: {pid(), Tag :: term()},
                            StateName :: atom(), StateData :: term()) ->
    {reply, Reply :: term(), NextStateName :: atom(), NewStateData :: term()} |
    {reply, Reply :: term(), NextStateName :: atom(), NewStateData :: term(),
     timeout() | hibernate} |
    {next_state, NextStateName :: atom(), NewStateData :: term()} |
    {next_state, NextStateName :: atom(), NewStateData :: term(),
     timeout() | hibernate} |
    {stop, Reason :: term(), Reply :: term(), NewStateData :: term()} |
    {stop, Reason :: term(), NewStateData :: term()}.
-callback handle_info(Info :: term(), StateName :: atom(),
                      StateData :: term()) ->
    {next_state, NextStateName :: atom(), NewStateData :: term()} |
    {next_state, NextStateName :: atom(), NewStateData :: term(),
     timeout() | hibernate} |
    {stop, Reason :: normal | term(), NewStateData :: term()}.
-callback terminate(Reason :: normal | shutdown | {shutdown, term()}
		    | term(), StateName :: atom(), StateData :: term()) ->
    term().
-callback code_change(OldVsn :: term() | {down, term()}, StateName :: atom(),
		      StateData :: term(), Extra :: term()) ->
    {ok, NextStateName :: atom(), NewStateData :: term()}.
-callback format_status(Opt, StatusData) -> Status when
      Opt :: 'normal' | 'terminate',
      StatusData :: [PDict | State],
      PDict :: [{Key :: term(), Value :: term()}],
      State :: term(),
      Status :: term().

-optional_callbacks(
    [handle_info/3, terminate/3, code_change/4, format_status/2]).

%%% ---------------------------------------------------
%%% Starts a generic state machine.
%%% start(Mod, Args, Options)
%%% start(Name, Mod, Args, Options)
%%% start_link(Mod, Args, Options)
%%% start_link(Name, Mod, Args, Options) where:
%%%    Name ::= {local, atom()} | {global, term()} | {via, atom(), term()}
%%%    Mod  ::= atom(), callback module implementing the 'real' fsm
%%%    Args ::= term(), init arguments (to Mod:init/1)
%%%    Options ::= [{debug, [Flag]}]
%%%      Flag ::= trace | log | {logfile, File} | statistics | debug
%%%          (debug == log && statistics)
%%% Returns: {ok, Pid} |
%%%          {error, {already_started, Pid}} |
%%%          {error, Reason}
%%% ---------------------------------------------------
-doc false.
start(Mod, Args, Options) ->
    gen:start(?MODULE, nolink, Mod, Args, Options).

-doc false.
start(Name, Mod, Args, Options) ->
    gen:start(?MODULE, nolink, Name, Mod, Args, Options).

-doc false.
start_link(Mod, Args, Options) ->
    gen:start(?MODULE, link, Mod, Args, Options).

-doc false.
start_link(Name, Mod, Args, Options) ->
    gen:start(?MODULE, link, Name, Mod, Args, Options).

-doc false.
stop(Name) ->
    gen:stop(Name).

-doc false.
stop(Name, Reason, Timeout) ->
    gen:stop(Name, Reason, Timeout).

-doc false.
send_event({global, Name}, Event) ->
    catch global:send(Name, {'$gen_event', Event}),
    ok;
send_event({via, Mod, Name}, Event) ->
    catch Mod:send(Name, {'$gen_event', Event}),
    ok;
send_event(Name, Event) ->
    Name ! {'$gen_event', Event},
    ok.

-doc false.
sync_send_event(Name, Event) ->
    case catch gen:call(Name, '$gen_sync_event', Event) of
	{ok,Res} ->
	    Res;
	{'EXIT',Reason} ->
	    exit({Reason, {?MODULE, sync_send_event, [Name, Event]}})
    end.

-doc false.
sync_send_event(Name, Event, Timeout) ->
    case catch gen:call(Name, '$gen_sync_event', Event, Timeout) of
	{ok,Res} ->
	    Res;
	{'EXIT',Reason} ->
	    exit({Reason, {?MODULE, sync_send_event, [Name, Event, Timeout]}})
    end.

-doc false.
send_all_state_event({global, Name}, Event) ->
    catch global:send(Name, {'$gen_all_state_event', Event}),
    ok;
send_all_state_event({via, Mod, Name}, Event) ->
    catch Mod:send(Name, {'$gen_all_state_event', Event}),
    ok;
send_all_state_event(Name, Event) ->
    Name ! {'$gen_all_state_event', Event},
    ok.

-doc false.
sync_send_all_state_event(Name, Event) ->
    case catch gen:call(Name, '$gen_sync_all_state_event', Event) of
	{ok,Res} ->
	    Res;
	{'EXIT',Reason} ->
	    exit({Reason, {?MODULE, sync_send_all_state_event, [Name, Event]}})
    end.

-doc false.
sync_send_all_state_event(Name, Event, Timeout) ->
    case catch gen:call(Name, '$gen_sync_all_state_event', Event, Timeout) of
	{ok,Res} ->
	    Res;
	{'EXIT',Reason} ->
	    exit({Reason, {?MODULE, sync_send_all_state_event,
			   [Name, Event, Timeout]}})
    end.

%% Designed to be only callable within one of the callbacks
%% hence using the self() of this instance of the process.
%% This is to ensure that timers don't go astray in global
%% e.g. when straddling a failover, or turn up in a restarted
%% instance of the process.

%% Returns Ref, sends event {timeout,Ref,Msg} after Time 
%% to the (then) current state.
-doc false.
start_timer(Time, Msg) ->
    erlang:start_timer(Time, self(), {'$gen_timer', Msg}).

%% Returns Ref, sends Event after Time to the (then) current state.
-doc false.
send_event_after(Time, Event) ->
    erlang:start_timer(Time, self(), {'$gen_event', Event}).

%% Returns the remaining time for the timer if Ref referred to
%% an active timer/send_event_after, false otherwise.
-doc false.
cancel_timer(Ref) ->
    case erlang:cancel_timer(Ref) of
	false ->
	    receive {timeout, Ref, _} -> 0
	    after 0 -> false 
	    end;
	RemainingTime ->
	    RemainingTime
    end.

%% enter_loop/4,5,6
%% Makes an existing process into a gen_fsm.
%% The calling process will enter the gen_fsm receive loop and become a
%% gen_fsm process.
%% The process *must* have been started using one of the start functions
%% in proc_lib, see proc_lib(3).
%% The user is responsible for any initialization of the process,
%% including registering a name for it.
-doc false.
enter_loop(Mod, Options, StateName, StateData) ->
    enter_loop(Mod, Options, StateName, StateData, self(), infinity).

-doc false.
enter_loop(Mod, Options, StateName, StateData, {Scope,_} = ServerName)
  when Scope == local; Scope == global ->
    enter_loop(Mod, Options, StateName, StateData, ServerName,infinity);
enter_loop(Mod, Options, StateName, StateData, {via,_,_} = ServerName) ->
    enter_loop(Mod, Options, StateName, StateData, ServerName,infinity);
enter_loop(Mod, Options, StateName, StateData, Timeout) ->
    enter_loop(Mod, Options, StateName, StateData, self(), Timeout).

-doc false.
enter_loop(Mod, Options, StateName, StateData, ServerName, Timeout) ->
    Name = gen:get_proc_name(ServerName),
    Parent = gen:get_parent(),
    Debug = gen:debug_options(Name, Options),
	HibernateAfterTimeout = gen:hibernate_after(Options),
    loop(Parent, Name, StateName, StateData, Mod, Timeout, HibernateAfterTimeout, Debug).

%%% ---------------------------------------------------
%%% Initiate the new process.
%%% Register the name using the Rfunc function
%%% Calls the Mod:init/Args function.
%%% Finally an acknowledge is sent to Parent and the main
%%% loop is entered.
%%% ---------------------------------------------------
-doc false.
init_it(Starter, self, Name, Mod, Args, Options) ->
    init_it(Starter, self(), Name, Mod, Args, Options);
init_it(Starter, Parent, Name0, Mod, Args, Options) ->
    Name = gen:name(Name0),
    Debug = gen:debug_options(Name, Options),
    HibernateAfterTimeout = gen:hibernate_after(Options),
    case catch Mod:init(Args) of
	{ok, StateName, StateData} ->
	    proc_lib:init_ack(Starter, {ok, self()}),
	    loop(Parent, Name, StateName, StateData, Mod, infinity, HibernateAfterTimeout, Debug);
	{ok, StateName, StateData, Timeout} ->
	    proc_lib:init_ack(Starter, {ok, self()}),
	    loop(Parent, Name, StateName, StateData, Mod, Timeout, HibernateAfterTimeout, Debug);
	{stop, Reason} ->
            gen:unregister_name(Name0),
            exit(Reason);
	ignore ->
	    gen:unregister_name(Name0),
	    proc_lib:init_fail(Starter, ignore, {exit, normal});
	{'EXIT', Reason} ->
	    gen:unregister_name(Name0),
            exit(Reason);
	Else ->
	    Reason = {bad_return_value, Else},
            exit(Reason)
    end.

%%-----------------------------------------------------------------
%% The MAIN loop
%%-----------------------------------------------------------------
loop(Parent, Name, StateName, StateData, Mod, hibernate, HibernateAfterTimeout, Debug) ->
    proc_lib:hibernate(?MODULE,wake_hib,
		       [Parent, Name, StateName, StateData, Mod, HibernateAfterTimeout,
			Debug]);

loop(Parent, Name, StateName, StateData, Mod, infinity, HibernateAfterTimeout, Debug) ->
	receive
		Msg ->
			decode_msg(Msg,Parent, Name, StateName, StateData, Mod, infinity, HibernateAfterTimeout, Debug, false)
	after HibernateAfterTimeout ->
		loop(Parent, Name, StateName, StateData, Mod, hibernate, HibernateAfterTimeout, Debug)
	end;

loop(Parent, Name, StateName, StateData, Mod, Time, HibernateAfterTimeout, Debug) ->
    Msg = receive
	      Input ->
		    Input
	  after Time ->
		  {'$gen_event', timeout}
	  end,
    decode_msg(Msg,Parent, Name, StateName, StateData, Mod, Time, HibernateAfterTimeout, Debug, false).

-doc false.
wake_hib(Parent, Name, StateName, StateData, Mod, HibernateAfterTimeout, Debug) ->
    Msg = receive
	      Input ->
		  Input
	  end,
    decode_msg(Msg, Parent, Name, StateName, StateData, Mod, hibernate, HibernateAfterTimeout, Debug, true).

decode_msg(Msg,Parent, Name, StateName, StateData, Mod, Time, HibernateAfterTimeout, Debug, Hib) ->
    case Msg of
        {system, From, Req} ->
	    sys:handle_system_msg(Req, From, Parent, ?MODULE, Debug,
				  [Name, StateName, StateData, Mod, Time, HibernateAfterTimeout], Hib);
	{'EXIT', Parent, Reason} ->
	    terminate(
              Reason, Name, undefined, Msg, Mod, StateName, StateData, Debug);
	_Msg when Debug =:= [] ->
	    handle_msg(Msg, Parent, Name, StateName, StateData, Mod, Time, HibernateAfterTimeout);
	_Msg ->
	    Debug1 = sys:handle_debug(Debug, fun print_event/3,
				      Name, {in, Msg, StateName}),
	    handle_msg(Msg, Parent, Name, StateName, StateData,
		       Mod, Time, HibernateAfterTimeout, Debug1)
    end.

%%-----------------------------------------------------------------
%% Callback functions for system messages handling.
%%-----------------------------------------------------------------
-doc false.
system_continue(Parent, Debug, [Name, StateName, StateData, Mod, Time, HibernateAfterTimeout]) ->
    loop(Parent, Name, StateName, StateData, Mod, Time, HibernateAfterTimeout, Debug).

-doc false.
-spec system_terminate(term(), _, _, [term(),...]) -> no_return().

system_terminate(Reason, _Parent, Debug,
		 [Name, StateName, StateData, Mod, _Time, _HibernateAfterTimeout]) ->
    terminate(Reason, Name, undefined, [], Mod, StateName, StateData, Debug).

-doc false.
system_code_change([Name, StateName, StateData, Mod, Time, HibernateAfterTimeout],
		   _Module, OldVsn, Extra) ->
    case catch Mod:code_change(OldVsn, StateName, StateData, Extra) of
	{ok, NewStateName, NewStateData} ->
	    {ok, [Name, NewStateName, NewStateData, Mod, Time, HibernateAfterTimeout]};
	Else -> Else
    end.

-doc false.
system_get_state([_Name, StateName, StateData, _Mod, _Time, _HibernateAfterTimeout]) ->
    {ok, {StateName, StateData}}.

-doc false.
system_replace_state(StateFun, [Name, StateName, StateData, Mod, Time, HibernateAfterTimeout]) ->
    Result = {NStateName, NStateData} = StateFun({StateName, StateData}),
    {ok, Result, [Name, NStateName, NStateData, Mod, Time, HibernateAfterTimeout]}.

%%-----------------------------------------------------------------
%% Format debug messages.  Print them as the call-back module sees
%% them, not as the real erlang messages.  Use trace for that.
%%-----------------------------------------------------------------
print_event(Dev, {in, Msg, StateName}, Name) ->
    case Msg of
	{'$gen_event', Event} ->
	    io:format(Dev, "*DBG* ~tp got event ~tp in state ~tw~n",
		      [Name, Event, StateName]);
	{'$gen_all_state_event', Event} ->
	    io:format(Dev,
		      "*DBG* ~tp got all_state_event ~tp in state ~tw~n",
		      [Name, Event, StateName]);
	{'$gen_sync_event', {From,_Tag}, Event} ->
	    io:format(Dev,
                      "*DBG* ~tp got sync_event ~tp "
                      "from ~tw in state ~tw~n",
		      [Name, Event, From, StateName]);
	{'$gen_sync_all_state_event', {From,_Tag}, Event} ->
	    io:format(Dev,
		      "*DBG* ~tp got sync_all_state_event ~tp "
                      "from ~tw in state ~tw~n",
		      [Name, Event, From, StateName]);
	{timeout, Ref, {'$gen_timer', Message}} ->
	    io:format(Dev,
		      "*DBG* ~tp got timer ~tp in state ~tw~n",
		      [Name, {timeout, Ref, Message}, StateName]);
	{timeout, _Ref, {'$gen_event', Event}} ->
	    io:format(Dev,
		      "*DBG* ~tp got timer ~tp in state ~tw~n",
		      [Name, Event, StateName]);
	_ ->
	    io:format(Dev, "*DBG* ~tp got ~tp in state ~tw~n",
		      [Name, Msg, StateName])
    end;
print_event(Dev, {out, Msg, {To,_Tag}, StateName}, Name) ->
    io:format(Dev, "*DBG* ~tp sent ~tp to ~tw~n"
	           "      and switched to state ~tw~n",
	      [Name, Msg, To, StateName]);
print_event(Dev, {noreply, StateName}, Name) ->
    io:format(Dev, "*DBG* ~tp switched to state ~tw~n",
	      [Name, StateName]).

handle_msg(Msg, Parent, Name, StateName, StateData, Mod, _Time, HibernateAfterTimeout) -> %No debug here
    From = from(Msg),
    case catch dispatch(Msg, Mod, StateName, StateData) of
	{next_state, NStateName, NStateData} ->	    
	    loop(Parent, Name, NStateName, NStateData, Mod, infinity, HibernateAfterTimeout, []);
	{next_state, NStateName, NStateData, Time1} ->
	    loop(Parent, Name, NStateName, NStateData, Mod, Time1, HibernateAfterTimeout, []);
        {reply, Reply, NStateName, NStateData} when From =/= undefined ->
	    reply(From, Reply),
	    loop(Parent, Name, NStateName, NStateData, Mod, infinity, HibernateAfterTimeout, []);
        {reply, Reply, NStateName, NStateData, Time1} when From =/= undefined ->
	    reply(From, Reply),
	    loop(Parent, Name, NStateName, NStateData, Mod, Time1, HibernateAfterTimeout, []);
	{stop, Reason, NStateData} ->
	    terminate(Reason, Name, From, Msg, Mod, StateName, NStateData, []);
	{stop, Reason, Reply, NStateData} when From =/= undefined ->
	    {'EXIT', R} = (catch terminate(Reason, Name, From, Msg, Mod,
					   StateName, NStateData, [])),
	    reply(From, Reply),
	    exit(R);
        {'EXIT', {undef, [{Mod, handle_info, [_,_,_], _}|_]}} ->
            ?LOG_WARNING(#{label=>{gen_fsm,no_handle_info},
                           module=>Mod,
                           message=>Msg},
                         #{domain=>[otp],
                           report_cb=>fun gen_fsm:format_log/2,
                         error_logger=>
                             #{tag=>warning_msg,
                               report_cb=>fun gen_fsm:format_log/1}}),
            loop(Parent, Name, StateName, StateData, Mod, infinity, HibernateAfterTimeout, []);
	{'EXIT', What} ->
	    terminate(What, Name, From, Msg, Mod, StateName, StateData, []);
	Reply ->
	    terminate({bad_return_value, Reply},
		      Name, From, Msg, Mod, StateName, StateData, [])
    end.

handle_msg(Msg, Parent, Name, StateName, StateData, Mod, _Time, HibernateAfterTimeout, Debug) ->
    From = from(Msg),
    case catch dispatch(Msg, Mod, StateName, StateData) of
	{next_state, NStateName, NStateData} ->
	    Debug1 = sys:handle_debug(Debug, fun print_event/3,
				      Name, {noreply, NStateName}),
	    loop(Parent, Name, NStateName, NStateData, Mod, infinity, HibernateAfterTimeout, Debug1);
	{next_state, NStateName, NStateData, Time1} ->
	    Debug1 = sys:handle_debug(Debug, fun print_event/3,
				      Name, {noreply, NStateName}),
	    loop(Parent, Name, NStateName, NStateData, Mod, Time1, HibernateAfterTimeout, Debug1);
        {reply, Reply, NStateName, NStateData} when From =/= undefined ->
	    Debug1 = reply(Name, From, Reply, Debug, NStateName),
	    loop(Parent, Name, NStateName, NStateData, Mod, infinity, HibernateAfterTimeout, Debug1);
        {reply, Reply, NStateName, NStateData, Time1} when From =/= undefined ->
	    Debug1 = reply(Name, From, Reply, Debug, NStateName),
	    loop(Parent, Name, NStateName, NStateData, Mod, Time1, HibernateAfterTimeout, Debug1);
	{stop, Reason, NStateData} ->
	    terminate(
              Reason, Name, From, Msg, Mod, StateName, NStateData, Debug);
	{stop, Reason, Reply, NStateData} when From =/= undefined ->
	    {'EXIT', R} = (catch terminate(Reason, Name, From, Msg, Mod,
					   StateName, NStateData, Debug)),
	    _ = reply(Name, From, Reply, Debug, StateName),
	    exit(R);
	{'EXIT', What} ->
	    terminate(What, Name, From, Msg, Mod, StateName, StateData, Debug);
	Reply ->
	    terminate({bad_return_value, Reply},
		      Name, From, Msg, Mod, StateName, StateData, Debug)
    end.

dispatch({'$gen_event', Event}, Mod, StateName, StateData) ->
    Mod:StateName(Event, StateData);
dispatch({'$gen_all_state_event', Event}, Mod, StateName, StateData) ->
    Mod:handle_event(Event, StateName, StateData);
dispatch({'$gen_sync_event', From, Event}, Mod, StateName, StateData) ->
    Mod:StateName(Event, From, StateData);
dispatch({'$gen_sync_all_state_event', From, Event},
	 Mod, StateName, StateData) ->
    Mod:handle_sync_event(Event, From, StateName, StateData);
dispatch({timeout, Ref, {'$gen_timer', Msg}}, Mod, StateName, StateData) ->
    Mod:StateName({timeout, Ref, Msg}, StateData);
dispatch({timeout, _Ref, {'$gen_event', Event}}, Mod, StateName, StateData) ->
    Mod:StateName(Event, StateData);
dispatch(Info, Mod, StateName, StateData) ->
    Mod:handle_info(Info, StateName, StateData).

from({'$gen_sync_event', From, _Event}) -> From;
from({'$gen_sync_all_state_event', From, _Event}) -> From;
from(_) -> undefined.

%% Send a reply to the client.
-doc false.
reply(From, Reply) ->
    gen:reply(From, Reply).

reply(Name, From, Reply, Debug, StateName) ->
    reply(From, Reply),
    sys:handle_debug(Debug, fun print_event/3, Name,
		     {out, Reply, From, StateName}).

%%% ---------------------------------------------------
%%% Terminate the server.
%%% ---------------------------------------------------

-spec terminate(term(), _, _, _, atom(), _, _, _) -> no_return().

terminate(Reason, Name, From, Msg, Mod, StateName, StateData, Debug) ->
    case erlang:function_exported(Mod, terminate, 3) of
	true ->
	    case catch Mod:terminate(Reason, StateName, StateData) of
		{'EXIT', R} ->
		    FmtStateData = format_status(terminate, Mod, get(), StateData),
		    error_info(
                      R, Name, From, Msg, StateName, FmtStateData, Debug),
		    exit(R);
		_ ->
		    ok
	    end;
	false ->
	    ok
    end,
    case Reason of
	normal ->
	    exit(normal);
	shutdown ->
	    exit(shutdown);
 	{shutdown,_}=Shutdown ->
 	    exit(Shutdown);
	_ ->
	    FmtStateData1 = format_status(terminate, Mod, get(), StateData),
	    error_info(
              Reason, Name, From, Msg, StateName, FmtStateData1, Debug),
	    exit(Reason)
    end.

error_info(Reason, Name, From, Msg, StateName, StateData, Debug) ->
    Log = sys:get_log(Debug),
    ?LOG_ERROR(#{label=>{gen_fsm,terminate},
                 name=>Name,
                 last_message=>Msg,
                 state_name=>StateName,
                 state_data=>StateData,
                 log=>Log,
                 reason=>Reason,
                 client_info=>client_stacktrace(From),
                 process_label=>proc_lib:get_label(self())},
               #{domain=>[otp],
                 report_cb=>fun gen_fsm:format_log/2,
                 error_logger=>#{tag=>error,
                                 report_cb=>fun gen_fsm:format_log/1}}),
    ok.

client_stacktrace(undefined) ->
    undefined;
client_stacktrace({Pid,_Tag}) ->
    client_stacktrace(Pid);
client_stacktrace(Pid) when is_pid(Pid), node(Pid) =:= node() ->
    case process_info(Pid, [current_stacktrace, registered_name]) of
        undefined ->
            {Pid,dead};
        [{current_stacktrace, Stacktrace}, {registered_name, []}]  ->
            {Pid,{Pid,Stacktrace}};
        [{current_stacktrace, Stacktrace}, {registered_name, Name}]  ->
            {Pid,{Name,Stacktrace}}
    end;
client_stacktrace(Pid) when is_pid(Pid) ->
    {Pid,remote}.


%% format_log/1 is the report callback used by Logger handler
%% error_logger only. It is kept for backwards compatibility with
%% legacy error_logger event handlers. This function must always
%% return {Format,Args} compatible with the arguments in this module's
%% calls to error_logger prior to OTP-21.0.
-doc false.
format_log(Report) ->
    Depth = error_logger:get_format_depth(),
    FormatOpts = #{chars_limit => unlimited,
                   depth => Depth,
                   single_line => false,
                   encoding => utf8},
    format_log_multi(limit_report(Report, Depth), FormatOpts).

limit_report(Report, unlimited) ->
    Report;
limit_report(#{label:={gen_fsm,terminate},
               last_message:=Msg,
               state_data:=StateData,
               log:=Log,
               reason:=Reason,
               client_info:=ClientInfo,
               process_label:=ProcessLabel}=Report,
            Depth) ->
    Report#{last_message=>io_lib:limit_term(Msg, Depth),
            state_data=>io_lib:limit_term(StateData, Depth),
            log=>[io_lib:limit_term(L, Depth) || L <- Log],
            reason=>io_lib:limit_term(Reason, Depth),
            client_info=>limit_client_report(ClientInfo, Depth),
            process_label=>io_lib:limit_term(ProcessLabel, Depth)};
limit_report(#{label:={gen_fsm,no_handle_info},
               message:=Msg}=Report, Depth) ->
    Report#{message=>io_lib:limit_term(Msg, Depth)}.

limit_client_report({From,{Name,Stacktrace}}, Depth) ->
    {From,{Name,io_lib:limit_term(Stacktrace, Depth)}};
limit_client_report(Client, _) ->
    Client.

%% format_log/2 is the report callback for any Logger handler, except
%% error_logger.
-doc false.
format_log(Report, FormatOpts0) ->
    Default = #{chars_limit => unlimited,
                depth => unlimited,
                single_line => false,
                encoding => utf8},
    FormatOpts = maps:merge(Default, FormatOpts0),
    IoOpts =
        case FormatOpts of
            #{chars_limit:=unlimited} ->
                [];
            #{chars_limit:=Limit} ->
                [{chars_limit,Limit}]
        end,
    {Format,Args} = format_log_single(Report, FormatOpts),
    io_lib:format(Format, Args, IoOpts).

format_log_single(#{label:={gen_fsm,terminate},
                    name:=Name,
                    last_message:=Msg,
                    state_name:=StateName,
                    state_data:=StateData,
                    log:=Log,
                    reason:=Reason,
                    client_info:=ClientInfo,
                    process_label:=ProcessLabel},
                  #{single_line:=true,depth:=Depth}=FormatOpts) ->
    P = p(FormatOpts),
    FixedReason = fix_reason(Reason),
    {ClientFmt,ClientArgs} = format_client_log_single(ClientInfo, P, Depth),
    Format =
        lists:append(
          ["State machine ",P," terminating",
           case ProcessLabel of
               undefined -> "";
               _ -> ". Label: "++P
           end,
           ". Reason: ",P,
           ". Last event: ",P,
           ". State: ",P,
           ". Data: ",P,
           case Log of
               [] -> "";
               _ -> ". Log: "++P
           end,
          "."]),
    Args0 =
        [Name] ++
        case ProcessLabel of
            undefined -> [];
            _ -> [ProcessLabel]
        end ++
        [FixedReason,get_msg(Msg),StateName,StateData] ++
        case Log of
            [] -> [];
            _ -> [Log]
        end,
    Args = case Depth of
               unlimited ->
                   Args0;
               _ ->
                   lists:flatmap(fun(A) -> [A, Depth] end, Args0)
           end,
    {Format++ClientFmt, Args++ClientArgs};
format_log_single(#{label:={gen_fsm,no_handle_info},
                    module:=Mod,
                    message:=Msg},
                  #{single_line:=true,depth:=Depth}=FormatOpts) ->
    P = p(FormatOpts),
    Format = lists:append(["Undefined handle_info in ",P,
                           ". Unhandled message: ",P,"."]),
    Args =
        case Depth of
            unlimited ->
                [Mod,Msg];
            _ ->
                [Mod,Depth,Msg,Depth]
        end,
    {Format,Args};
format_log_single(Report, FormatOpts) ->
    format_log_multi(Report, FormatOpts).

format_log_multi(#{label:={gen_fsm,terminate},
                   name:=Name,
                   last_message:=Msg,
                   state_name:=StateName,
                   state_data:=StateData,
                   log:=Log,
                   reason:=Reason,
                   client_info:=ClientInfo,
                   process_label:=ProcessLabel},
                 #{depth:=Depth}=FormatOpts) ->
    P = p(FormatOpts),
    FixedReason = fix_reason(Reason),
    {ClientFmt,ClientArgs} = format_client_log(ClientInfo, P, Depth),
    Format =
        lists:append(
          ["** State machine ",P," terminating \n",
           case ProcessLabel of
               undefined -> [];
               _ -> "** Process label == "++P++"~n"
           end,
           get_msg_str(Msg, P)++
           "** When State == ",P,"~n",
           "**      Data  == ",P,"~n",
           "** Reason for termination ==~n** ",P,"~n",
           case Log of
               [] -> [];
               _ -> "** Log ==~n**"++P++"~n"
           end]),
    Args0 =
        [Name|
         case ProcessLabel of
             undefined -> [];
             _ -> [ProcessLabel]
         end] ++
        get_msg(Msg) ++
        [StateName,StateData,FixedReason |
         case Log of
             [] -> [];
             _ -> [Log]
         end],
    Args = case Depth of
               unlimited ->
                   Args0;
               _ ->
                   lists:flatmap(fun(A) -> [A, Depth] end, Args0)
           end,
    {Format++ClientFmt,Args++ClientArgs};
format_log_multi(#{label:={gen_fsm,no_handle_info},
                   module:=Mod,
                   message:=Msg},
                 #{depth:=Depth}=FormatOpts) ->
    P = p(FormatOpts),
    Format =
        "** Undefined handle_info in ~p~n"
        "** Unhandled message: "++P++"~n",
    Args =
        case Depth of
            unlimited ->
                [Mod,Msg];
            _ ->
                [Mod,Msg,Depth]
        end,
    {Format,Args}.

fix_reason({undef,[{M,F,A,L}|MFAs]}=Reason) ->
    case code:is_loaded(M) of
        false ->
            {'module could not be loaded',[{M,F,A,L}|MFAs]};
        _ ->
            case erlang:function_exported(M, F, length(A)) of
                true ->
                    Reason;
                false ->
                    {'function not exported',[{M,F,A,L}|MFAs]}
            end
    end;
fix_reason(Reason) ->
    Reason.

get_msg_str({'$gen_event', _Event}, P) ->
    "** Last event in was "++P++"~n";
get_msg_str({'$gen_sync_event', _From, _Event}, P) ->
    "** Last sync event in was "++P++" from ~tw~n";
get_msg_str({'$gen_all_state_event', _Event}, P) ->
    "** Last event in was "++P++" (for all states)~n";
get_msg_str({'$gen_sync_all_state_event', _From, _Event}, P) ->
    "** Last sync event in was "++P++" (for all states) from "++P++"~n";
get_msg_str({timeout, _Ref, {'$gen_timer', _Msg}}, P) ->
    "** Last timer event in was "++P++"~n";
get_msg_str({timeout, _Ref, {'$gen_event', _Msg}}, P) ->
    "** Last timer event in was "++P++"~n";
get_msg_str(_Msg, P) ->
    "** Last message in was "++P++"~n".

get_msg({'$gen_event', Event}) -> [Event];
get_msg({'$gen_sync_event', {From,_Tag}, Event}) -> [Event,From];
get_msg({'$gen_all_state_event', Event}) -> [Event];
get_msg({'$gen_sync_all_state_event', {From,_Tag}, Event}) -> [Event,From];
get_msg({timeout, Ref, {'$gen_timer', Msg}}) -> [{timeout, Ref, Msg}];
get_msg({timeout, _Ref, {'$gen_event', Event}}) -> [Event];
get_msg(Msg) -> [Msg].

format_client_log_single(undefined, _, _) ->
    {"", []};
format_client_log_single({Pid,dead}, _, _) ->
    {" Client ~0p is dead.", [Pid]};
format_client_log_single({Pid,remote}, _, _) ->
    {" Client ~0p is remote on node ~0p.", [Pid,node(Pid)]};
format_client_log_single({_Pid,{Name,Stacktrace0}}, P, Depth) ->
    %% Minimize the stacktrace a bit for single line reports. This is
    %% hopefully enough to point out the position.
    Stacktrace = lists:sublist(Stacktrace0, 4),
    Format = lists:append([" Client ",P," stacktrace: ",P,"."]),
    Args = case Depth of
               unlimited ->
                   [Name, Stacktrace];
               _ ->
                   [Name, Depth, Stacktrace, Depth]
           end,
    {Format, Args}.

format_client_log(undefined, _, _) ->
    {"", []};
format_client_log({Pid,dead}, _, _) ->
    {"** Client ~p is dead~n", [Pid]};
format_client_log({Pid,remote}, _, _) ->
    {"** Client ~p is remote on node ~p~n", [Pid,node(Pid)]};
format_client_log({_Pid,{Name,Stacktrace}}, P, Depth) ->
    Format = lists:append(["** Client ",P," stacktrace~n** ",P,"~n"]),
    Args = case Depth of
               unlimited ->
                   [Name, Stacktrace];
               _ ->
                   [Name, Depth, Stacktrace, Depth]
           end,
    {Format,Args}.

p(#{single_line:=Single,depth:=Depth,encoding:=Enc}) ->
    "~"++single(Single)++mod(Enc)++p(Depth);
p(unlimited) ->
    "p";
p(_Depth) ->
    "P".

single(true) -> "0";
single(false) -> "".

mod(latin1) -> "";
mod(_) -> "t".

%%-----------------------------------------------------------------
%% Status information
%%-----------------------------------------------------------------
-doc false.
format_status(Opt, StatusData) ->
    [PDict, SysState, Parent, Debug, [Name, StateName, StateData, Mod, _Time, _HibernateAfterTimeout]] =
	StatusData,
    Header = gen:format_status_header("Status for state machine",
                                      Name),
    Log = sys:get_log(Debug),
    Specific =
        case format_status(Opt, Mod, PDict, StateData) of
            S when is_list(S) -> S;
            S -> [S]
        end,
    [{header, Header},
     {data, [{"Status", SysState},
	     {"Parent", Parent},
	     {"Logged events", Log},
	     {"StateName", StateName}]} |
     Specific].

format_status(Opt, Mod, PDict, State) ->
    DefStatus = case Opt of
		    terminate -> State;
		    _ -> [{data, [{"StateData", State}]}]
		end,
    case erlang:function_exported(Mod, format_status, 2) of
	true ->
	    case catch Mod:format_status(Opt, [PDict, State]) of
		{'EXIT', _} -> DefStatus;
		Else -> Else
	    end;
	_ ->
	    DefStatus
    end.
