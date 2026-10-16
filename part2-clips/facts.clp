;;; Part 2 - CLIPS: the person template and the starting facts.
;;;
;;; Same family tree as Part 1, so the two halves of the lab can be
;;; compared side by side. Everything in here is given; nothing is
;;; derived. rules.clp takes these facts and forward chains the rest
;;; of the relationships out of them.
;;;
;;; Tree layout, oldest generation on the left:
;;;
;;;   john --+-- mary --+-- susan -- tom --+-- alice
;;;          |          |                  +-- brian
;;;          |          +-- david -- emma
;;;          +-- peter -- laura -- jack

;;; One fact per person. `parent` is `none` for the root of the tree,
;;; which the rules use to know where to stop.
(deftemplate person
   (slot name)
   (slot parent (default none))
   (slot gender (allowed-values male female)))

(deffacts family-tree

   ;; generation 1
   (person (name john)  (parent none)  (gender male))

   ;; generation 2
   (person (name mary)  (parent john)  (gender female))
   (person (name peter) (parent john)  (gender male))

   ;; generation 3
   (person (name susan) (parent mary)  (gender female))
   (person (name david) (parent mary)  (gender male))
   (person (name laura) (parent peter) (gender female))

   ;; generation 4
   (person (name tom)   (parent susan) (gender male))
   (person (name emma)  (parent david) (gender female))
   (person (name jack)  (parent laura) (gender male))

   ;; generation 5
   (person (name alice) (parent tom)   (gender female))
   (person (name brian) (parent tom)   (gender male)))
