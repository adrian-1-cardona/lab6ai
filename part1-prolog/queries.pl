% Part 1 - Prolog: query runner.
%
% Loads the facts and rules, asks a handful of yes/no questions, then
% lists every solution of every relation so you can see what backward
% chaining derived from the tree.
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


% ask(+Goal)
% Run one goal and report true/false, the way a ?- query would.
ask(Goal) :-
    ( call(Goal) -> Answer = true ; Answer = false ),
    format("  ?- ~w.~t~32| ~w~n", [Goal, Answer]).


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


main :-
    format("Part 1: Prolog, backward chaining~n~n"),
    format("Direct questions:~n"),
    ask(ancestor(john, tom)),
    ask(mother(mary, susan)),
    ask(brother(tom, alice)),
    ask(brother(brian, alice)),
    ask(cousin(susan, alice)),
    ask(cousin(tom, emma)),
    ask(grandchild(tom, john)),
    ask(grandchild(tom, mary)),
    ask(uncle(david, tom)),
    ask(second_cousin(tom, jack)),
    format("~nAll solutions, relation by relation:~n"),
    forall(reported_relation(R), show(R)),
    nl.

:- initialization(main, main).
