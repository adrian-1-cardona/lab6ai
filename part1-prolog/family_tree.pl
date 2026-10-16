% Part 1 - Prolog: the family tree facts.
%
% This file holds nothing but ground facts. Three predicates is all
% the knowledge base needs:
%
%   parent(Parent, Child)  - Parent is a direct parent of Child
%   male(Person)
%   female(Person)
%
% Every other relationship (ancestor, uncle, cousin, ...) is derived
% in rules.pl. Keeping the facts separate is what makes the backward
% chaining easy to follow: a query unwinds through the rules and
% either lands on a fact in here, or fails.
%
% Tree layout, oldest generation on the left:
%
%   john --+-- mary --+-- susan -- tom --+-- alice
%          |          |                  +-- brian
%          |          +-- david -- emma
%          +-- peter -- laura -- jack


% parent(Parent, Child)

% generation 1 to 2
parent(john,  mary).
parent(john,  peter).

% generation 2 to 3
parent(mary,  susan).
parent(mary,  david).
parent(peter, laura).

% generation 3 to 4
parent(susan, tom).
parent(david, emma).
parent(laura, jack).

% generation 4 to 5
parent(tom,   alice).
parent(tom,   brian).


% male(Person)

male(john).
male(peter).
male(david).
male(tom).
male(jack).
male(brian).


% female(Person)

female(mary).
female(susan).
female(laura).
female(emma).
female(alice).
