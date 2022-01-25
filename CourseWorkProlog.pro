domains
	list = integer*
predicates
	findlist(integer, list, string, list)
	findlist_if(string, list, list)
clauses
	findlist(OBJ, [H|[]], TEST, R1):- TEST="=", H=OBJ, R1=[H].
	findlist(OBJ, [H|[]], TEST, R1):- TEST="=", H<>OBJ, R1=[].
	findlist(OBJ, [H|T], TEST, R):- TEST="=", H=OBJ, findlist(OBJ, T, TEST, RES), R=[H|RES], !.
	findlist(OBJ, [H|T], TEST, R):- TEST="=", H<>OBJ, findlist(OBJ, T, TEST, RES), R=RES, !.
	
	findlist(OBJ, [H|[]], TEST, R1):- TEST="<", H<OBJ, R1=[H].
	findlist(OBJ, [H|[]], TEST, R1):- TEST="<", H>=OBJ, R1=[].
	findlist(OBJ, [H|T], TEST, R):- TEST="<", H<OBJ, findlist(OBJ, T, TEST, RES), R=[H|RES], !.
	findlist(OBJ, [H|T], TEST, R):- TEST="<", H>=OBJ, findlist(OBJ, T, TEST, RES), R=RES, !.
	
	findlist(OBJ, [H|[]], TEST, R1):- TEST=">", H>OBJ, R1=[H].
	findlist(OBJ, [H|[]], TEST, R1):- TEST=">", H<=OBJ, R1=[].
	findlist(OBJ, [H|T], TEST, R):- TEST=">", H>OBJ, findlist(OBJ, T, TEST, RES), R=[H|RES], !.
	findlist(OBJ, [H|T], TEST, R):- TEST=">", H<=OBJ, findlist(OBJ, T, TEST, RES), R=RES, !.
	
	findlist(OBJ, [H|[]], TEST, R1):- TEST="<=", H<=OBJ, R1=[H].
	findlist(OBJ, [H|[]], TEST, R1):- TEST="<=", H>OBJ, R1=[].
	findlist(OBJ, [H|T], TEST, R):- TEST="<=", H<=OBJ, findlist(OBJ, T, TEST, RES), R=[H|RES], !.
	findlist(OBJ, [H|T], TEST, R):- TEST="<=", H>OBJ, findlist(OBJ, T, TEST, RES), R=RES, !.
	
	findlist(OBJ, [H|[]], TEST, R1):- TEST=">=", H>=OBJ, R1=[H].
	findlist(OBJ, [H|[]], TEST, R1):- TEST=">=", H<OBJ, R1=[].
	findlist(OBJ, [H|T], TEST, R):- TEST=">=", H>=OBJ, findlist(OBJ, T, TEST, RES), R=[H|RES], !.
	findlist(OBJ, [H|T], TEST, R):- TEST=">=", H<OBJ, findlist(OBJ, T, TEST, RES), R=RES, !.
	
	findlist(OBJ, [H|[]], TEST, R1):- TEST="<>", H<>OBJ, R1=[H].
	findlist(OBJ, [H|[]], TEST, R1):- TEST="<>", H=OBJ, R1=[].
	findlist(OBJ, [H|T], TEST, R):- TEST="<>", H<>OBJ, findlist(OBJ, T, TEST, RES), R=[H|RES], !.
	findlist(OBJ, [H|T], TEST, R):- TEST="<>", H=OBJ, findlist(OBJ, T, TEST, RES), R=RES, !.
	
	findlist_if(TEST, [H|[]], R1):- TEST="+", H>0, R1=[H].
	findlist_if(TEST, [H|[]], R1):- TEST="+", H<=0, R1=[].
	findlist_if(TEST, [H|T], R):- TEST="+", H>0, findlist_if(TEST, T, RES), R=[H|RES], !.
	findlist_if(TEST, [H|T], R):- TEST="+", H<=0, findlist_if(TEST, T, RES), R=RES, !.
	
	findlist_if(TEST, [H|[]], R1):- TEST="-", H<0, R1=[H].
	findlist_if(TEST, [H|[]], R1):- TEST="-", H>=0, R1=[].
	findlist_if(TEST, [H|T], R):- TEST="-", H<0, findlist_if(TEST, T, RES), R=[H|RES], !.
	findlist_if(TEST, [H|T], R):- TEST="-", H>=0, findlist_if(TEST, T, RES), R=RES, !.
	
	findlist_if(TEST, [H|[]], R1):- TEST="odd", H mod 2 = 1, R1=[H].
	findlist_if(TEST, [H|[]], R1):- TEST="odd", H mod 2 = 0, R1=[].
	findlist_if(TEST, [H|T], R):- TEST="odd", H mod 2 = 1, findlist_if(TEST, T, RES), R=[H|RES], !.
	findlist_if(TEST, [H|T], R):- TEST="odd", H mod 2 = 0, findlist_if(TEST, T, RES), R=RES, !.
	
	findlist_if(TEST, [H|[]], R1):- TEST="even", H mod 2 = 0, R1=[H].
	findlist_if(TEST, [H|[]], R1):- TEST="even", H mod 2 = 1, R1=[].
	findlist_if(TEST, [H|T], R):- TEST="even", H mod 2 = 0, findlist_if(TEST, T, RES), R=[H|RES], !.
	findlist_if(TEST, [H|T], R):- TEST="even", H mod 2 = 1, findlist_if(TEST, T, RES), R=RES, !.
	
%--------------------------------------------------------------------------------------------------------
domains
	sentence = string*
database
	noun(string)
	verb(string)
	adj(string)
predicates
	analysis(sentence)
	sent(sentence, sentence)
	noun_group(sentence, sentence)
	verb_group(sentence, sentence)
clauses
	analysis(L):- sent(L, L1),!,analysis(L1).
	analysis([]).
	
	sent(L, L0):- noun_group(L, L1), verb_group(L1, L0).
	noun_group([X|L], L):- noun(X), !.
	noun_group([X,Y|L], L):- adj(X), noun(Y), !.
	noun_group([X,Y,Z|L], L):- adj(X), adj(Y), noun(Z), !.
	verb_group([X|L], L):- verb(X),!.

	noun("table"). noun("chair"). noun("teacup"). noun("notebook").
	adj("big"). adj("comfortable"). adj("beautiful"). adj("clear"). adj("expensive").
	verb("stands"). verb("lies"). verb("works"). verb("exists").