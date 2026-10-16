;;; Part 2 - CLIPS: reporting what the engine derived.
;;;
;;; Forward chaining has already put every derived fact in working
;;; memory by the time these run, so "querying" is just reading it
;;; back out with find-all-facts.
;;;
;;; Loaded and called by run.clp. To type the Task 3 queries yourself,
;;; start clips from inside this folder and enter:
;;;
;;;   (load* "facts.clp")
;;;   (load* "rules.clp")
;;;   (reset)
;;;   (run)
;;;   (find-all-facts ((?m mother)) TRUE)
;;;   (find-all-facts ((?b brother)) TRUE)
;;;   (find-all-facts ((?c cousin)) TRUE)

;;; Derived relations are ordered facts, so all their arguments sit in
;;; the implied multifield slot.
(deffunction print-relation (?label ?facts)
   (printout t crlf ?label ":" crlf)
   (if (= (length$ ?facts) 0)
      then
         (printout t "  (none)" crlf)
      else
         (progn$ (?f ?facts)
            (printout t "  (" ?label " "
                        (implode$ (fact-slot-value ?f implied)) ")" crlf))))

;;; The three relations Task 3 asks to be queried.
(deffunction task-queries ()
   (printout t crlf "The three Task 3 queries:" crlf)
   (print-relation "mother"  (find-all-facts ((?m mother)) TRUE))
   (print-relation "brother" (find-all-facts ((?b brother)) TRUE))
   (print-relation "cousin"  (find-all-facts ((?c cousin)) TRUE)))

;;; Everything else in working memory, including the relations added
;;; in Task 2, so each new rule is shown to have fired.
(deffunction other-relations ()
   (printout t crlf "Everything else the rules derived:" crlf)
   (print-relation "parent"        (find-all-facts ((?f parent)) TRUE))
   (print-relation "ancestor"      (find-all-facts ((?f ancestor)) TRUE))
   (print-relation "father"        (find-all-facts ((?f father)) TRUE))
   (print-relation "sibling"       (find-all-facts ((?f sibling)) TRUE))
   (print-relation "sister"        (find-all-facts ((?f sister)) TRUE))
   (print-relation "grandparent"   (find-all-facts ((?f grandparent)) TRUE))
   (print-relation "grandmother"   (find-all-facts ((?f grandmother)) TRUE))
   (print-relation "grandfather"   (find-all-facts ((?f grandfather)) TRUE))
   (print-relation "grandchild"    (find-all-facts ((?f grandchild)) TRUE))
   (print-relation "uncle"         (find-all-facts ((?f uncle)) TRUE))
   (print-relation "aunt"          (find-all-facts ((?f aunt)) TRUE))
   (print-relation "second_cousin" (find-all-facts ((?f second_cousin)) TRUE)))

(deffunction run-queries ()
   (printout t crlf "Part 2: CLIPS, forward chaining" crlf)
   (task-queries)
   (other-relations)
   (printout t crlf))
