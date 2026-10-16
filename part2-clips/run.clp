;;; Part 2 - CLIPS: batch driver.
;;;
;;; Run from inside this folder so the relative loads resolve:
;;;   clips -f run.clp

(clear)
(load* "facts.clp")
(load* "rules.clp")
(load* "queries.clp")

;;; reset puts the deffacts into working memory, run lets the rules
;;; forward chain until nothing new can be derived. The ancestors get
;;; printed by print-ancestor as they are inferred.
(reset)
(run)

(run-queries)
(exit)
