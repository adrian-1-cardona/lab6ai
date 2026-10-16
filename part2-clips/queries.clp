;;; Part 2 - CLIPS: reporting what the engine derived.
;;;
;;; Forward chaining has already put every derived fact in working
;;; memory by the time these run, so "querying" is just reading it
;;; back out with find-all-facts.
;;;
;;; Loaded and called by run.clp. By hand:
;;;   (run-queries)

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

(deffunction run-queries ()
   (printout t crlf "Part 2: CLIPS, forward chaining" crlf)
   (print-relation "parent"        (find-all-facts ((?f parent)) TRUE))
   (print-relation "ancestor"      (find-all-facts ((?f ancestor)) TRUE))
   (print-relation "mother"        (find-all-facts ((?f mother)) TRUE))
   (print-relation "father"        (find-all-facts ((?f father)) TRUE))
   (print-relation "sibling"       (find-all-facts ((?f sibling)) TRUE))
   (print-relation "brother"       (find-all-facts ((?f brother)) TRUE))
   (print-relation "sister"        (find-all-facts ((?f sister)) TRUE))
   (print-relation "grandparent"   (find-all-facts ((?f grandparent)) TRUE))
   (print-relation "grandmother"   (find-all-facts ((?f grandmother)) TRUE))
   (print-relation "grandfather"   (find-all-facts ((?f grandfather)) TRUE))
   (print-relation "grandchild"    (find-all-facts ((?f grandchild)) TRUE))
   (print-relation "uncle"         (find-all-facts ((?f uncle)) TRUE))
   (print-relation "aunt"          (find-all-facts ((?f aunt)) TRUE))
   (print-relation "cousin"        (find-all-facts ((?f cousin)) TRUE))
   (print-relation "second-cousin" (find-all-facts ((?f second-cousin)) TRUE))
   (printout t crlf))
