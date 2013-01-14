; non-trivial helper
(watch all)
(reset)
(defrule do-anything
  "A rule for anything."
  ?ne <- (anything)
  =>
  (printout t "Someone did something.")
  (retract ?ne))
(assert (anything))
(run)
