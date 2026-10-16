% ============================================================
% Part 1 - Prolog: derived relationship rules
%
% This is where backward chaining happens. Each rule reads as
% "the head holds IF the body holds". Prolog starts from the goal
% you ask about, replaces it with the body of a matching rule,
% and repeats until every sub-goal bottoms out in a fact from
% family_tree.pl. If no path reaches the facts, the goal fails.
%
% Convention for every relation below: the first argument is the
% person being described, the second is who they are related to.
% So mother(mary, susan) reads "mary is the mother of susan".
% ============================================================

:- ensure_loaded(family_tree).

% --- ancestry -----------------------------------------------
% Two clauses: Prolog tries the first, and on failure (or when
% asked for more solutions) falls back to the recursive one.

% Base case: a direct parent is an ancestor.
ancestor(X, Y) :- parent(X, Y).

% Recursive case: step down one generation, then keep looking.
ancestor(X, Y) :- parent(X, Z), ancestor(Z, Y).

% --- immediate family ---------------------------------------

mother(X, Y) :- parent(X, Y), female(X).
father(X, Y) :- parent(X, Y), male(X).

% Two people are siblings if they share a parent and are not
% the same person. The X \== Y guard is what stops everyone
% from coming out as their own sibling.
sibling(X, Y) :- parent(Z, X), parent(Z, Y), X \== Y.

brother(X, Y) :- sibling(X, Y), male(X).
sister(X, Y)  :- sibling(X, Y), female(X).

% --- grandparents -------------------------------------------

grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
grandmother(X, Y) :- grandparent(X, Y), female(X).
grandfather(X, Y) :- grandparent(X, Y), male(X).

% Just grandparent read the other way round.
grandchild(X, Y) :- grandparent(Y, X).

% --- aunts and uncles ---------------------------------------
% A sibling of one of your parents.

uncle(X, Y) :- brother(X, Z), parent(Z, Y).
aunt(X, Y)  :- sister(X, Z),  parent(Z, Y).

% --- cousins ------------------------------------------------

% First cousins: their parents are siblings.
cousin(X, Y) :- parent(Z, X), parent(W, Y), sibling(Z, W).

% Second cousins: their parents are first cousins.
second_cousin(X, Y) :- parent(A, X), parent(B, Y), cousin(A, B).
