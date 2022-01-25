(defun @FINDLIST (obj lst test)
	(cond
		((not (listp lst)) 'non-list)
		((null lst) 'list-empty)
		(T (FINDLIST1 obj lst test)) ) )

(defun FINDLIST1 (obj lst test) 
	(if (null test) (setq test 'EQUAL) )
	(cond
		((null lst) nil)
		((funcall test obj (car lst)) (cons (car lst) (FINDLIST1 obj (cdr lst) test)))
		(T (FINDLIST1 obj (cdr lst) test) ) )  )
;----------------------------------------------------------------------------
(defun @FINDLIST-IF (test lst)
	(cond
		((not (listp lst)) 'non-list)
		((null lst) 'list-empty)
		(T (FINDLIST-IF1 test lst)) ) )

(defun FINDLIST-IF1 (test lst)
	(cond
		((null lst) nil)
		((funcall test (car lst)) (cons (car lst) (FINDLIST-IF1 test (cdr lst))))
		(T (FINDLIST-IF1 test (cdr lst))) ) )
;----------------------------------------------------------------------------
;Рекурсивная реализация
(defun @INSEND-R (atm lst)
	(cond
		((null lst) nil)
		((atom lst) nil)
		(T (INSEND1-R atm lst)) ) )

(defun INSEND1-R (atm lst)
	(cond
		((null lst) (list atm))
		((atom (car lst)) (cons (car lst) (INSEND1-R atm (cdr lst)) ))
		((listp (car lst)) (cons (INSEND1-R atm (car lst)) (INSEND1-R atm (cdr lst)) ))
		(T nil) ) )
;----------------------------------------------------------------------------
;Итерационная реализация
(defun @INSEND-I (atm lst r)
	(setq r nil)
	(INSEND1-I
		(cons atm
		(loop
			((null lst) r)
			(push (cond
				((atom (car lst)) (pop lst))
				(T (@INSEND-I atm (pop lst))) ) r) ) )) )

(defun INSEND1-I (lst r)
	(setq r nil)
	(loop
		((null lst) r)
		(push (car lst) r)
		(pop lst) ) )
;----------------------------------------------------------------------------
;Реализация с использованием функционала
(defun @INSEND-F (atm lst)
	(cond
		((atom lst) lst)
		((listp lst) (append
			(mapcar '(lambda (lst1)(@INSEND-F atm lst1)) lst)
			(list atm)) ) ) )