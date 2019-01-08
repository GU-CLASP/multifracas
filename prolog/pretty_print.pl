% a toy pretty-printer, originally by Mark Johnson

% modified by rhc

:- public pprint/1.

:- op( 250, xfy, [ : ] ).
:- op( 200, fx, [ @ ] ).

pprint( X ) :-
	abolish(gennum,1),
	assert(gennum(0)),
	nl,
	ppx( X, 0,[],_ ),!,
	nl.

pprintq( X ) :-
	abolish(gennum,1),
	assert(gennum(0)),
	nl,
	ppxq( X, 0,[],_ ),!,
	nl.

% ppx( Expr, Indent )
%
%	assumes we are already positioned at Indent

ppx( X, _,Printed,Printed ) :- ( atomicOrVar(X) ;
	         ( X =.. L,
		   listlen(L, I),
		   I =< 8,
		   applist( atomicOrVar, L ) ) ;
		 ( ( X = [] ; X = [_|_] ),
		   listlen(X, I ),
		   I =< 16,
		   applist( atomicOrVar, X ) ) ),
	       !,
	       write(X).

ppx( [], _,P,P ) :- !, write([]).	

ppx(@L, _,Printed,Printed) :- tail(L,T),assoc(T,N,Printed),!,
	write('***'), write(N).
ppx( @L, I,Printed,POut ) :- !, write('@'), J is I+1, tail(L,T),
	gensym(N),
	ppx(L,J,[(T,N)|Printed],POut).

ppx( Att:Val, I,Printed,POut ) :- !, write( Att ), write( ' : ' ), atomlen( Att, J),
		     K is I + J + 3, ppx(Val, K,Printed,POut).

ppx( [ H | R ], I,PIn,POut ) :- !, write( '[' ), J is I + 1, ppx( H, J,PIn,POut1),
		       pplist(R,J,POut1,POut), write(']').

ppx( X, I,PIn,POut ) :- X =.. [F,A1|AR], write(F), write('('), atomlen(F,J),
	       K is I + J + 1, ppx(A1,K,PIn,POut1), pplist(AR,K,POut1,POut), write(')').


ppxq( X, _,Printed,Printed ) :- ( atomicOrVar(X) ;
	         ( X =.. L,
		   listlen(L, I),
		   I =< 8,
		   applist( atomicOrVar, L ) ) ;
		 ( ( X = [] ; X = [_|_] ),
		   listlen(X, I ),
		   I =< 16,
		   applist( atomicOrVar, X ) ) ),
	       !,
	       writeq(X).

ppxq( [], _,P,P ) :- !, write([]).	

ppxq(@L, _,Printed,Printed) :- tail(L,T),assoc(T,N,Printed),!,
	write('***'), writeq(N).
ppxq( @L, I,Printed,POut ) :- !, write('@'), J is I+1, tail(L,T),
	gensym(N),
	ppxq(L,J,[(T,N)|Printed],POut).

ppxq( Att:Val, I,Printed,POut ) :- !, writeq( Att ), write( ' : ' ), atomlen( Att, J),
		     K is I + J + 3, ppxq(Val, K,Printed,POut).

ppxq( [ H | R ], I,PIn,POut ) :- !, write( '[' ), J is I + 1, ppxq( H, J,PIn,POut1),
		       pplistq(R,J,POut1,POut), write(']').

ppxq( X, I,PIn,POut ) :- X =.. [F,A1|AR], writeq(F), write('('), atomlen(F,J),
	       K is I + J + 1, ppxq(A1,K,PIn,POut1), pplistq(AR,K,POut1,POut), write(')').

pplist( X, I,P,P ) :- var(X), !, nl, J is I - 1, tab(J), write('| '), 
	assoc(X,N,P),
	write( N ).
pplist( [], _,P,P) :- !.
pplist( [ H | R ], I,PIn,POut ) :-
	!,
	write(','),
	nl,
	tab(I),
	ppx(H,I,PIn,POut1),
	pplist( R, I,POut1,POut).
pplist( X, I,PIn,POut ) :- nl, J is I - 1, tab(J), write( '| '), K is I + 1, ppx(X,K,PIn,POut).

pplistq( X, I,P,P ) :- var(X), !, nl, J is I - 1, tab(J), write('| '), 
	assoc(X,N,P),
	writeq( N ).
pplistq( [], _,P,P) :- !.
pplistq( [ H | R ], I,PIn,POut ) :-
	!,
	write(','),
	nl,
	tab(I),
	ppxq(H,I,PIn,POut1),
	pplistq( R, I,POut1,POut).
pplistq( X, I,PIn,POut ) :- nl, J is I - 1, tab(J), write( '| '), K is I + 1, ppxq(X,K,PIn,POut).
	      

listlen( X, 1 ) :- var(X), !.
listlen( [], 0 ).
listlen( [_|L], I ) :- listlen(L,J), I is J + 1.

applist(_,X) :- var(X), !.
applist(_,[]).
applist(F,[H|R]) :- P =.. [F,H], call(P), applist(F,R).

atomlen( A, I ) :- name(A,L), listlen(L,I).

atomicOrVar( X ) :- atomic(X) ; var(X).

assoc(_,_,L) :- var(L),!,fail.
assoc(X,N,[(Y,N)|L]) :- X==Y,!.
assoc(X,N,[_|L]) :- assoc(X,N,L).

gensym(N) :-
	retract(gennum(M)),
	N is M+1,
	assert(gennum(N)).

:- assert(gennum(0)).