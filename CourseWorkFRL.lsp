; Реализовать функцию (ANALYSIS sentence), позволяющую распознать синтаксически правильные предложения русского языка.
(defun ANALYSIS (sentence)
	(setq s_copy sentence)
	(setq fl 0)
	(setq struct (fget GRAMMAR))
	(setq verb 0)
	(loop
		((or (null s_copy) (= fl 1) ))
		(setq fl1 (is_in_map (car s_copy) map))
		(cond
			((null fl1)
				(setq fl 1)
				(princ "Word ") (princ (car s_copy)) (princ " is not included in map! ")
				null
			)
			(T
				(setq pstruct (fget GRAMMAR (car struct)))
				(cond
					((equal (car (fget fl1 ЧАСТЬ-РЕЧИ)) (car pstruct))
						(setq s_copy (cdr s_copy))
						(cond
							((null (cdr pstruct))
								(setq struct (cdr struct)) 
							)
							(T
								(setq pstruct (cdr pstruct))
							)
						)
						(if (equal (car (fget fl1 ЧАСТЬ-РЕЧИ)) ГЛАГОЛ) (setq verb 1))
					)
					(T
						(cond
							((equal (car pstruct) ПРИЛАГАТЕЛЬНОЕ) 
								(setq struct (cdr struct))
							)
							(T (setq fl 1) )
						)
					)
				)
			)
		)
	)
	(cond
		((and (= fl 0) (= verb 1)) True)
		(T False)
	)
)

(deframeq GRAMMAR
	(S1 ($value (ПРИЛАГАТЕЛЬНОЕ) (ПРИЛАГАТЕЛЬНОЕ)))
	(S2 ($value (СУЩЕСТВИТЕЛЬНОЕ)))
	(S3 ($value (ГЛАГОЛ)))
)

(deframeq big
	(ЧАСТЬ-РЕЧИ ($value (ПРИЛАГАТЕЛЬНОЕ))) )
(deframeq comfortable
	(ЧАСТЬ-РЕЧИ ($value (ПРИЛАГАТЕЛЬНОЕ))) )
(deframeq beautiful
	(ЧАСТЬ-РЕЧИ ($value (ПРИЛАГАТЕЛЬНОЕ))) )
(deframeq clear
	(ЧАСТЬ-РЕЧИ ($value (ПРИЛАГАТЕЛЬНОЕ))) )
(deframeq expensive
	(ЧАСТЬ-РЕЧИ ($value (ПРИЛАГАТЕЛЬНОЕ))) )

(deframeq table
	(ЧАСТЬ-РЕЧИ ($value (СУЩЕСТВИТЕЛЬНОЕ))) )
(deframeq chair
	(ЧАСТЬ-РЕЧИ ($value (СУЩЕСТВИТЕЛЬНОЕ))) )
(deframeq teacup
	(ЧАСТЬ-РЕЧИ ($value (СУЩЕСТВИТЕЛЬНОЕ))) )
(deframeq notebook
	(ЧАСТЬ-РЕЧИ ($value (СУЩЕСТВИТЕЛЬНОЕ))) )

(deframeq stands
	(ЧАСТЬ-РЕЧИ ($value (ГЛАГОЛ))) )
(deframeq lies
	(ЧАСТЬ-РЕЧИ ($value (ГЛАГОЛ))) )
(deframeq works
	(ЧАСТЬ-РЕЧИ ($value (ГЛАГОЛ))) )
(deframeq exists
	(ЧАСТЬ-РЕЧИ ($value (ГЛАГОЛ))) )

(setq map (list big comfortable beautiful clear expensive table chair teacup notebook stands lies works exists))

(defun is_in_map (word lst)
	(if (not (null lst))
		(cond
			((equal (car lst) word) (car lst))
			(T (is_in_map word (cdr lst)))
		)
	)
)