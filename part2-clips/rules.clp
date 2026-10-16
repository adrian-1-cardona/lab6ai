;;; Part 2 - CLIPS: forward chaining rules.
;;;
;;; The mirror image of Part 1. Nothing is asked for here. Every rule
;;; whose left-hand side matches the current facts fires and asserts
;;; something new, and those new facts can match other rules, which
;;; fire in turn. (run) keeps going until no rule has anything left
;;; to add.
;;;
;;; Derived facts are plain ordered facts written as
;;;   (relation <person> <who-they-relate-to>)
;;; so (mother mary susan) reads "mary is the mother of susan". The
;;; relation names and the argument order are kept identical to the
;;; Prolog predicates in Part 1 so the two halves can be diffed.
;;;
;;; Two deliberate changes from the sample code in the lab handout:
;;;
;;;   1. The sample find-ancestor asserts new `person` facts, which
;;;      overwrites the family tree with wrong parents and then feeds
;;;      those back into every other rule. Ancestry is derived into
;;;      its own `ancestor` relation here instead, leaving the person
;;;      facts as the record of what was actually given.
;;;
;;;   2. The sample find-mother and find-father have the arguments
;;;      backwards: matching (name ?x) (parent ?y) (gender female) and
;;;      asserting (mother ?x ?y) says the child is the mother of the
;;;      parent, and it tests the child's gender rather than the
;;;      parent's. The rules below check the parent's gender and
;;;      assert parent first.


;;; Parent and ancestry.

;;; Lift the parent slot out into its own fact so the rest of the
;;; rules can chain on it without re-matching the person template.
(defrule parent-of
   (person (name ?child) (parent ?p&~none))
   =>
   (assert (parent ?p ?child)))

(defrule ancestor-direct
   (parent ?p ?c)
   =>
   (assert (ancestor ?p ?c)))

;;; Transitive closure: an ancestor of an ancestor is an ancestor.
;;; CLIPS will not assert a fact that already exists, so this runs out
;;; of new work instead of looping forever.
(defrule ancestor-transitive
   (ancestor ?a ?x)
   (ancestor ?x ?d)
   =>
   (assert (ancestor ?a ?d)))

;;; Forward chaining is visible here: this fires the moment an
;;; ancestor fact shows up, including the ones the rule above derives
;;; several steps later.
(defrule print-ancestor
   (ancestor ?a ?d)
   =>
   (printout t "  " ?a " is an ancestor of " ?d crlf))


;;; Immediate family.

(defrule mother-of
   (parent ?p ?c)
   (person (name ?p) (gender female))
   =>
   (assert (mother ?p ?c)))

(defrule father-of
   (parent ?p ?c)
   (person (name ?p) (gender male))
   =>
   (assert (father ?p ?c)))

;;; Shared parent, different people. The test is what keeps anyone
;;; from being matched as their own sibling.
(defrule sibling-of
   (parent ?p ?x)
   (parent ?p ?y)
   (test (neq ?x ?y))
   =>
   (assert (sibling ?x ?y)))

(defrule brother-of
   (sibling ?x ?y)
   (person (name ?x) (gender male))
   =>
   (assert (brother ?x ?y)))

(defrule sister-of
   (sibling ?x ?y)
   (person (name ?x) (gender female))
   =>
   (assert (sister ?x ?y)))


;;; Grandparents.

(defrule grandparent-of
   (parent ?g ?p)
   (parent ?p ?c)
   =>
   (assert (grandparent ?g ?c)))

(defrule grandmother-of
   (grandparent ?g ?c)
   (person (name ?g) (gender female))
   =>
   (assert (grandmother ?g ?c)))

(defrule grandfather-of
   (grandparent ?g ?c)
   (person (name ?g) (gender male))
   =>
   (assert (grandfather ?g ?c)))

;;; Same relationship, stated from the grandchild's side.
(defrule grandchild-of
   (grandparent ?g ?c)
   =>
   (assert (grandchild ?c ?g)))


;;; Aunts and uncles: a sibling of one of your parents.

(defrule uncle-of
   (brother ?u ?p)
   (parent ?p ?c)
   =>
   (assert (uncle ?u ?c)))

(defrule aunt-of
   (sister ?a ?p)
   (parent ?p ?c)
   =>
   (assert (aunt ?a ?c)))


;;; Cousins.

;;; First cousins: their parents are siblings.
(defrule cousin-of
   (parent ?p1 ?x)
   (parent ?p2 ?y)
   (sibling ?p1 ?p2)
   =>
   (assert (cousin ?x ?y)))

;;; Second cousins: their parents are first cousins.
(defrule second-cousin-of
   (parent ?p1 ?x)
   (parent ?p2 ?y)
   (cousin ?p1 ?p2)
   =>
   (assert (second_cousin ?x ?y)))
