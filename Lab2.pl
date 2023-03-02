func(L, L1):-
    mainfunc(L, L1, _). 

mainfunc([], [], 0).
mainfunc([A|L], [B|L1], B):-
    mainfunc(L, L1, Pm),
    maxf(A, Pm, B).

maxf(El, Row, Ans):-
    El>=0, Row>=0, Ans is 0, !.
maxf(El, Row, Ans):-
    El<0, Row>=0, Ans is El, !.
maxf(El, Row, Ans):-
    El>=0, Row<0, Ans is Row, !.
maxf(El, Row, Ans):-
    El<0, Row<0, Ans is max(El, Row), !.

%?- func([5, 7, -1, 4, -3, -2, 3, -9, 5, 7], L1)
