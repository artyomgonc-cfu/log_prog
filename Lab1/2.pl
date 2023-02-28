minpos(A,B,X) :-
	A =< 0,
    B =< 0,
    X is -9999,
    !.
minpos(A,B,X) :-
	A =< 0,
    X is B,
    !.
minpos(A,B,X) :-
	B =< 0,
    X is A,
    !.
minpos(A,B,X) :-
	A > B,
    X is B,
    !.
minpos(A,B,X):-
	A=<B,
    X is A,
    !.
    
main :-
	read(A),
    read(B),
    read(C),
    minpos(A,B,X),
    minpos(X,C,Ans),
    (Ans == -9999 -> writeln("Error") ; writeln(Ans)).
	
%?- main
