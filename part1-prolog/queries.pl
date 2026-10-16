% Part 1 - Prolog: query runner.
%
% Loads the facts and rules, asks the lab's questions with a note on
% why each answer comes out the way it does, then lists every solution
% of every relation so you can see what backward chaining derived from
% the tree.
%
%   swipl -q -s part1-prolog/queries.pl
%
% To poke at it by hand instead:
%
%   swipl part1-prolog/rules.pl
%   ?- ancestor(john, tom).

:- ensure_loaded(rules).


% The relations reported at the bottom of the run, in family order.
reported_relation(parent).
reported_relation(ancestor).
reported_relation(mother).
reported_relation(father).
reported_relation(sibling).
reported_relation(brother).
reported_relation(sister).
reported_relation(grandparent).
reported_relation(grandmother).
reported_relation(grandfather).
reported_relation(grandchild).
reported_relation(uncle).
reported_relation(aunt).
reported_relation(cousin).
reported_relation(second_cousin).


% ask(+Goal, +Why)
% Run one goal and report true/false the way a ?- query would, plus a
% note explaining the result so a false answer can be told apart from
% a missing rule.
ask(Goal, Why) :-
    ( call(Goal) -> Answer = true ; Answer = false ),
    format("  ?- ~w.~t~34|~w~t~42|~w~n", [Goal, Answer, Why]).


% show(+Name)
% List every distinct pair satisfying the binary relation Name.
% setof/3 both sorts and removes the duplicate solutions you get when
% a relation can be proved along more than one path.
show(Name) :-
    Goal =.. [Name, X, Y],
    format("~n~w:~n", [Name]),
    (   setof(X-Y, Goal, Pairs)
    ->  forall(member(A-B, Pairs),
               format("  ~w(~w, ~w)~n", [Name, A, B]))
    ;   format("  (none)~n")
    ).


% The two queries given as examples in the lab.
example_queries :-
    format("~nThe lab's two example queries:~n"),
    ask(ancestor(john, tom),
        "john -> mary -> susan -> tom"),
    ask(mother(mary, susan),
        "mary is susan's parent and female").

% The three queries the lab asks for in Task 3. All three are false,
% and that is the correct answer rather than a missing rule: the tree
% the lab tells us to build puts these people in different positions
% than the query names suggest. Task 3 asks for the queries, not for
% them to succeed.
task_queries :-
    format("~nThe three Task 3 queries:~n"),
    ask(brother(tom, alice),
        "alice is tom's daughter, not his sister"),
    ask(cousin(susan, alice),
        "susan is alice's grandmother"),
    ask(grandchild(tom, john),
        "john is tom's great-grandfather").

% The same three relations, aimed at people who do stand in them, so
% the rules are shown working and not just failing.
control_queries :-
    format("~nThe same three relations where they do hold:~n"),
    ask(brother(brian, alice),
        "both are tom's children and brian is male"),
    ask(cousin(tom, emma),
        "their parents susan and david are siblings"),
    ask(grandchild(tom, mary),
        "mary -> susan -> tom").

% One query per rule added in Task 2, so each of them is exercised.
added_rule_queries :-
    format("~nThe rules added in Task 2:~n"),
    ask(grandmother(mary, tom),
        "mary is tom's grandparent and female"),
    ask(grandfather(john, susan),
        "john is susan's grandparent and male"),
    ask(uncle(david, tom),
        "david is the brother of tom's mother susan"),
    ask(aunt(susan, emma),
        "susan is the sister of emma's father david"),
    ask(second_cousin(tom, jack),
        "their parents susan and laura are cousins").


main :-
    format("Part 1: Prolog, backward chaining~n"),
    example_queries,
    task_queries,
    control_queries,
    added_rule_queries,
    format("~nAll solutions, relation by relation:~n"),
    forall(reported_relation(R), show(R)),
    nl.

:- initialization(main, main).
