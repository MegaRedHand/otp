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
%% @copyright 1999-2002 Richard Carlsson
%% @author Richard Carlsson <carlsson.richard@gmail.com>
%% @doc Utility functions for Core Erlang case/receive clauses.
%%
%% <p>Syntax trees are defined in the module {@link cerl}.</p>
%%
%% @type cerl() = cerl:cerl()

-module(cerl_clauses).
-moduledoc """
Utility functions for Core Erlang case/receive clauses.

Syntax trees are defined in the module `m:cerl`.
""".

-export([any_catchall/1, eval_guard/1, is_catchall/1, match/2,
	 match_list/2, reduce/1, reduce/2]).

-import(cerl, [alias_pat/1, alias_var/1, data_arity/1, data_es/1,
	       data_type/1, clause_guard/1, clause_pats/1, concrete/1,
	       is_data/1, is_c_var/1, let_body/1, letrec_body/1,
	       seq_body/1, try_arg/1, type/1, values_es/1]).

-type cerl() :: cerl:cerl().

%% ---------------------------------------------------------------------

%% @spec is_catchall(Clause::cerl()) -> boolean()
%%
%% @doc Returns <code>true</code> if an abstract clause is a
%% catch-all, otherwise <code>false</code>. A clause is a catch-all if
%% all its patterns are variables, and its guard expression always
%% evaluates to <code>true</code>; cf. <code>eval_guard/1</code>.
%%
%% <p>Note: <code>Clause</code> must have type
%% <code>clause</code>.</p>
%%
%% @see eval_guard/1
%% @see any_catchall/1

-doc """
Returns `true` if an abstract clause is a catch-all, otherwise `false`. A clause
is a catch-all if all its patterns are variables, and its guard expression
always evaluates to `true`; cf. [`eval_guard/1`](`eval_guard/1`).

Note: `Clause` must have type `clause`.

_See also: _`any_catchall/1`, `eval_guard/1`.
""".
-spec is_catchall(cerl:c_clause()) -> boolean().

is_catchall(C) ->
    case all_vars(clause_pats(C)) of
	true ->
	    case eval_guard(clause_guard(C)) of
		{value, true} ->
		    true;
		_ ->
		    false
	    end;
	false ->
	    false
    end.

all_vars([C | Cs]) ->
    case is_c_var(C) of
	true ->
	    all_vars(Cs);
	false ->
	    false
    end;
all_vars([]) ->
    true.


%% @spec any_catchall(Clauses::[cerl()]) -> boolean()
%%
%% @doc Returns <code>true</code> if any of the abstract clauses in
%% the list is a catch-all, otherwise <code>false</code>.  See
%% <code>is_catchall/1</code> for details.
%%
%% <p>Note: each node in <code>Clauses</code> must have type
%% <code>clause</code>.</p>
%%
%% @see is_catchall/1

-doc """
Returns `true` if any of the abstract clauses in the list is a catch-all,
otherwise `false`. See [`is_catchall/1`](`is_catchall/1`) for details.

Note: each node in `Clauses` must have type `clause`.

_See also: _`is_catchall/1`.
""".
-spec any_catchall([cerl()]) -> boolean().

any_catchall([C | Cs]) ->
    case is_catchall(C) of
	true ->
	    true;
	false ->
	    any_catchall(Cs)
    end;
any_catchall([]) ->
    false.


%% @spec eval_guard(Expr::cerl()) -> none | {value, term()}
%%
%% @doc Tries to reduce a guard expression to a single constant value,
%% if possible. The returned value is <code>{value, Term}</code> if the
%% guard expression <code>Expr</code> always yields the constant value
%% <code>Term</code>, and is otherwise <code>none</code>.
%%
%% <p>Note that although guard expressions should only yield boolean
%% values, this function does not guarantee that <code>Term</code> is
%% either <code>true</code> or <code>false</code>. Also note that only
%% simple constructs like let-expressions are examined recursively;
%% general constant folding is not performed.</p>
%%
%% @see is_catchall/1

%% This function could possibly be improved further, but constant
%% folding should in general be performed elsewhere.

-doc """
Tries to reduce a guard expression to a single constant value, if possible. The
returned value is `{value, Term}` if the guard expression `Expr` always yields
the constant value `Term`, and is otherwise `none`.

Note that although guard expressions should only yield boolean values, this
function does not guarantee that `Term` is either `true` or `false`. Also note
that only simple constructs like let-expressions are examined recursively;
general constant folding is not performed.

_See also: _`is_catchall/1`.
""".
-spec eval_guard(cerl()) -> 'none' | {'value', term()}.

eval_guard(E) ->
    case type(E) of
	literal ->
	    {value, concrete(E)};
	values ->
	    case values_es(E) of
		[E1] ->
		    eval_guard(E1);
		_ ->
		    none
	    end;
	'try' ->
	    eval_guard(try_arg(E));
	seq ->
	    eval_guard(seq_body(E));
	'let' ->
	    eval_guard(let_body(E));
	'letrec' ->
	    eval_guard(letrec_body(E));
	_ ->
	    none
    end.


%% ---------------------------------------------------------------------

-type bindings() :: [{cerl(), cerl()}].

%% @spec reduce(Clauses) -> {true, {Clause, Bindings}}
%%                        | {false, Clauses}
%%
%% @equiv reduce(Cs, [])

-doc "Equivalent to [reduce(Cs, [])](`reduce/2`).".
-spec reduce([cerl:c_clause()]) ->
        {'true', {cerl:c_clause(), bindings()}} | {'false', [cerl:c_clause()]}.

reduce(Cs) ->
    reduce(Cs, []).

%% @spec reduce(Clauses::[Clause], Exprs::[Expr]) ->
%%           {true, {Clause, Bindings}}
%%         | {false, [Clause]}
%%
%%    Clause = cerl()
%%    Expr = any | cerl()
%%    Bindings = [{cerl(), cerl()}]
%%
%% @doc Selects a single clause, if possible, or otherwise reduces the
%% list of selectable clauses. The input is a list <code>Clauses</code>
%% of abstract clauses (i.e., syntax trees of type <code>clause</code>),
%% and a list of switch expressions <code>Exprs</code>. The function
%% tries to uniquely select a single clause or discard unselectable
%% clauses, with respect to the switch expressions. All abstract clauses
%% in the list must have the same number of patterns. If
%% <code>Exprs</code> is not the empty list, it must have the same
%% length as the number of patterns in each clause; see
%% <code>match_list/2</code> for details.
%% 
%% <p>A clause can only be selected if its guard expression always
%% yields the atom <code>true</code>, and a clause whose guard
%% expression always yields the atom <code>false</code> can never be
%% selected. Other guard expressions are considered to have unknown
%% value; cf. <code>eval_guard/1</code>.</p>
%%
%% <p>If a particular clause can be selected, the function returns
%% <code>{true, {Clause, Bindings}}</code>, where <code>Clause</code> is
%% the selected clause and <code>Bindings</code> is a list of pairs
%% <code>{Var, SubExpr}</code> associating the variables occurring in
%% the patterns of <code>Clause</code> with the corresponding
%% subexpressions in <code>Exprs</code>. The list of bindings is given
%% in innermost-first order; see the <code>match/2</code> function for
%% details.</p>
%% 
%% <p>If no clause could be definitely selected, the function returns
%% <code>{false, NewClauses}</code>, where <code>NewClauses</code> is
%% the list of entries in <code>Clauses</code> that remain after
%% eliminating unselectable clauses, preserving the relative order.</p>
%%
%% @see eval_guard/1
%% @see match/2
%% @see match_list/2

-type expr() :: 'any' | cerl().

-doc """
Selects a single clause, if possible, or otherwise reduces the list of
selectable clauses. The input is a list `Clauses` of abstract clauses (i.e.,
syntax trees of type `clause`), and a list of switch expressions `Exprs`. The
function tries to uniquely select a single clause or discard unselectable
clauses, with respect to the switch expressions. All abstract clauses in the
list must have the same number of patterns. If `Exprs` is not the empty list, it
must have the same length as the number of patterns in each clause; see
[`match_list/2`](`match_list/2`) for details.

A clause can only be selected if its guard expression always yields the atom
`true`, and a clause whose guard expression always yields the atom `false` can
never be selected. Other guard expressions are considered to have unknown value;
cf. [`eval_guard/1`](`eval_guard/1`).

If a particular clause can be selected, the function returns
`{true, {Clause, Bindings}}`, where `Clause` is the selected clause and
`Bindings` is a list of pairs `{Var, SubExpr}` associating the variables
occurring in the patterns of `Clause` with the corresponding subexpressions in
`Exprs`. The list of bindings is given in innermost-first order; see the
[`match/2`](`match/2`) function for details.

If no clause could be definitely selected, the function returns
`{false, NewClauses}`, where `NewClauses` is the list of entries in `Clauses`
that remain after eliminating unselectable clauses, preserving the relative
order.

_See also: _`eval_guard/1`, `match/2`, `match_list/2`.
""".
-spec reduce([cerl:c_clause()], [expr()]) ->
        {'true', {cerl:c_clause(), bindings()}} | {'false', [cerl:c_clause()]}.

reduce(Cs, Es) ->
    reduce(Cs, Es, []).

reduce([C | Cs], Es, Cs1) ->
    Ps = clause_pats(C),
    case match_list(Ps, Es) of
	none ->
	    %% Here, we know that the current clause cannot possibly be
	    %% selected, so we drop it and visit the rest.
	    reduce(Cs, Es, Cs1);
	{false, _} ->
	    %% We are not sure if this clause might be selected, so we
	    %% save it and visit the rest.
	    reduce(Cs, Es, [C | Cs1]);
	{true, Bs} ->
	    case eval_guard(clause_guard(C)) of
		{value, true} when Cs1 =:= [] ->
		    %% We have a definite match - we return the residual
		    %% expression and signal that a selection has been
		    %% made. All other clauses are dropped.
		    {true, {C, Bs}};
		{value, true} ->
		    %% Unless one of the previous clauses is selected,
		    %% this clause will definitely be, so we can drop
		    %% the rest.
		    {false, lists:reverse([C | Cs1])};
		{value, false} ->
		    %% This clause can never be selected, since its
		    %% guard is never 'true', so we drop it.
		    reduce(Cs, Es, Cs1);
		_ ->
		    %% We are not sure if this clause might be selected
		    %% (or might even cause a crash), so we save it and
		    %% visit the rest.
		    reduce(Cs, Es, [C | Cs1])
	    end
    end;
reduce([], _, Cs) ->
    %% All clauses visited, without a complete match. Signal "not
    %% reduced" and return the saved clauses, in the correct order.
    {false, lists:reverse(Cs)}.


%% ---------------------------------------------------------------------

%% @spec match(Pattern::cerl(), Expr) ->
%%           none | {true, Bindings} | {false, Bindings}
%%
%%     Expr = any | cerl()
%%     Bindings = [{cerl(), Expr}]
%%
%% @doc Matches a pattern against an expression. The returned value is
%% <code>none</code> if a match is impossible, <code>{true,
%% Bindings}</code> if <code>Pattern</code> definitely matches
%% <code>Expr</code>, and <code>{false, Bindings}</code> if a match is
%% not definite, but cannot be excluded. <code>Bindings</code> is then
%% a list of pairs <code>{Var, SubExpr}</code>, associating each
%% variable in the pattern with either the corresponding subexpression
%% of <code>Expr</code>, or with the atom <code>any</code> if no
%% matching subexpression exists. (Recall that variables may not be
%% repeated in a Core Erlang pattern.) The list of bindings is given
%% in innermost-first order; this should only be of interest if
%% <code>Pattern</code> contains one or more alias patterns. If the
%% returned value is <code>{true, []}</code>, it implies that the
%% pattern and the expression are syntactically identical.
%%
%% <p>Instead of a syntax tree, the atom <code>any</code> can be
%% passed for <code>Expr</code> (or, more generally, be used for any
%% subtree of <code>Expr</code>, in as much the abstract syntax tree
%% implementation allows it); this means that it cannot be decided
%% whether the pattern will match or not, and the corresponding
%% variable bindings will all map to <code>any</code>. The typical use
%% is for producing bindings for <code>receive</code> clauses.</p>
%%
%% <p>Note: Binary-syntax patterns are never structurally matched
%% against binary-syntax expressions by this function.</p>
%%
%% <p>Examples:
%% <ul>
%%   <li>Matching a pattern "<code>{X, Y}</code>" against the
%%   expression "<code>{foo, f(Z)}</code>" yields <code>{true,
%%   Bindings}</code> where <code>Bindings</code> associates
%%   "<code>X</code>" with the subtree "<code>foo</code>" and
%%   "<code>Y</code>" with the subtree "<code>f(Z)</code>".</li>
%%
%%   <li>Matching pattern "<code>{X, {bar, Y}}</code>" against
%%   expression "<code>{foo, f(Z)}</code>" yields <code>{false,
%%   Bindings}</code> where <code>Bindings</code> associates
%%   "<code>X</code>" with the subtree "<code>foo</code>" and
%%   "<code>Y</code>" with <code>any</code> (because it is not known
%%   if "<code>{foo, Y}</code>" might match the run-time value of
%%   "<code>f(Z)</code>" or not).</li>
%%
%%   <li>Matching pattern "<code>{foo, bar}</code>" against expression
%%   "<code>{foo, f()}</code>" yields <code>{false, []}</code>,
%%   telling us that there might be a match, but we cannot deduce any
%%   bindings.</li>
%%
%%   <li>Matching <code>{foo, X = {bar, Y}}</code> against expression
%%   "<code>{foo, {bar, baz}}</code>" yields <code>{true,
%%   Bindings}</code> where <code>Bindings</code> associates
%%   "<code>Y</code>" with "<code>baz</code>", and "<code>X</code>"
%%   with "<code>{bar, baz}</code>".</li>
%%
%%   <li>Matching a pattern "<code>{X, Y}</code>" against
%%   <code>any</code> yields <code>{false, Bindings}</code> where
%%   <code>Bindings</code> associates both "<code>X</code>" and
%%   "<code>Y</code>" with <code>any</code>.</li>
%% </ul></p>

-type match_ret() :: 'none' | {'true', bindings()} | {'false', bindings()}.

-doc """
Matches a pattern against an expression. The returned value is `none` if a match
is impossible, `{true, Bindings}` if `Pattern` definitely matches `Expr`, and
`{false, Bindings}` if a match is not definite, but cannot be excluded.
`Bindings` is then a list of pairs `{Var, SubExpr}`, associating each variable
in the pattern with either the corresponding subexpression of `Expr`, or with
the atom `any` if no matching subexpression exists. (Recall that variables may
not be repeated in a Core Erlang pattern.) The list of bindings is given in
innermost-first order; this should only be of interest if `Pattern` contains one
or more alias patterns. If the returned value is `{true, []}`, it implies that
the pattern and the expression are syntactically identical.

Instead of a syntax tree, the atom `any` can be passed for `Expr` (or, more
generally, be used for any subtree of `Expr`, in as much the abstract syntax
tree implementation allows it); this means that it cannot be decided whether the
pattern will match or not, and the corresponding variable bindings will all map
to `any`. The typical use is for producing bindings for `receive` clauses.

Note: Binary-syntax patterns are never structurally matched against
binary-syntax expressions by this function.

Examples:

- Matching a pattern "`{X, Y}`" against the expression "`{foo, f(Z)}`" yields
  `{true, Bindings}` where `Bindings` associates "`X`" with the subtree "`foo`"
  and "`Y`" with the subtree "`f(Z)`".
- Matching pattern "`{X, {bar, Y}}`" against expression "`{foo, f(Z)}`" yields
  `{false, Bindings}` where `Bindings` associates "`X`" with the subtree "`foo`"
  and "`Y`" with `any` (because it is not known if "`{foo, Y}`" might match the
  run-time value of "`f(Z)`" or not).
- Matching pattern "`{foo, bar}`" against expression "`{foo, f()}`" yields
  `{false, []}`, telling us that there might be a match, but we cannot deduce
  any bindings.
- Matching `{foo, X = {bar, Y}}` against expression "`{foo, {bar, baz}}`" yields
  `{true, Bindings}` where `Bindings` associates "`Y`" with "`baz`", and "`X`"
  with "`{bar, baz}`".
- Matching a pattern "`{X, Y}`" against `any` yields `{false, Bindings}` where
  `Bindings` associates both "`X`" and "`Y`" with `any`.
""".
-spec match(cerl(), expr()) -> match_ret().

match(P, E) ->
    match(P, E, []).

match(P, E, Bs) ->
    case type(P) of
	var ->
	    %% Variables always match, since they cannot have repeated
	    %% occurrences in a pattern.
	    {true, [{P, E} | Bs]};
	alias ->
	    %% All variables in P1 will be listed before the alias
	    %% variable in the result.
	    match(alias_pat(P), E, [{alias_var(P), E} | Bs]);
	binary ->
	    %% The most we can do is to say "definitely no match" if a
	    %% binary pattern is matched against non-binary data.
	    if E =:= any ->
		    {false, Bs};
	       true ->
		    case type(E) of
			literal ->
			    case is_bitstring(concrete(E)) of
				false ->
				    none;
				true ->
				    {false, Bs}
			    end;
			cons ->
			    none;
			tuple ->
			    none;
			_ ->
			    {false, Bs}
		    end
	    end;
	map ->
	    %% The most we can do is to say "definitely no match" if a
	    %% map pattern is matched against non-map data.
            %% (Note: See the document internal_doc/cerl-notes.md for
            %% information why we don't try to do more here.)
	    case E of
		any ->
		    {false, Bs};
		_ ->
		    case type(E) of
			literal ->
			    case is_map(concrete(E)) of
				false ->
				    none;
				true ->
				    {false, Bs}
			    end;
			cons ->
			    none;
			tuple ->
			    none;
			_ ->
			    {false, Bs}
		    end
	    end;
	_ ->
	    match_1(P, E, Bs)
    end.

match_1(P, E, Bs) ->
    case is_data(P) of
	true when E =:= any ->
	    %% If we don't know the structure of the value of E at this
	    %% point, we just match the subpatterns against 'any', and
	    %% make sure the result is a "maybe".
	    Ps = data_es(P),
	    Es = [any || _ <- Ps],
	    case match_list(Ps, Es, Bs) of
		{_, Bs1} ->
		    {false, Bs1};
		none ->
		    none
	    end;
	true ->
	    %% Test if the expression represents a constructor
	    case is_data(E) of
		true ->
		    T1 = {data_type(E), data_arity(E)},
		    T2 = {data_type(P), data_arity(P)},
		    %% Note that we must test for exact equality.
		    if T1 =:= T2 ->
			    match_list(data_es(P), data_es(E), Bs);
		       true ->
			    none
		    end;
		false ->
		    %% We don't know the run-time structure of E, and P
		    %% is not a variable or an alias pattern, so we
		    %% match against 'any' instead.
		    match_1(P, any, Bs)
	    end;
	false ->
	    %% Strange pattern - give up, but don't say "no match".
	    {false, Bs}
    end.


%% @spec match_list(Patterns::[cerl()], Exprs::[Expr]) ->
%%           none | {true, Bindings} | {false, Bindings}
%%
%%     Expr = any | cerl()
%%     Bindings = [{cerl(), cerl()}]
%%
%% @doc Like <code>match/2</code>, but matching a sequence of patterns
%% against a sequence of expressions. Passing an empty list for
%% <code>Exprs</code> is equivalent to passing a list of
%% <code>any</code> atoms of the same length as <code>Patterns</code>.
%%
%% @see match/2

-doc """
Like [`match/2`](`match/2`), but matching a sequence of patterns against a
sequence of expressions. Passing an empty list for `Exprs` is equivalent to
passing a list of `any` atoms of the same length as `Patterns`.

_See also: _`match/2`.
""".
-spec match_list([cerl()], [expr()]) -> match_ret().

match_list([], []) ->
    {true, []};    % no patterns always match
match_list(Ps, []) ->
    match_list(Ps, [any || _ <- Ps], []);
match_list(Ps, Es) ->
    match_list(Ps, Es, []).

match_list([P | Ps], [E | Es], Bs) ->
    case match(P, E, Bs) of
	{true, Bs1} ->
	    match_list(Ps, Es, Bs1);
	{false, Bs1} ->
	    %% Make sure "maybe" is preserved
	    case match_list(Ps, Es, Bs1) of
		{_, Bs2} ->
		    {false, Bs2};
		none ->
		    none
	    end;
	none ->
	    none
    end;
match_list([], [], Bs) ->
    {true, Bs}.
