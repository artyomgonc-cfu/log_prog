% (C/D)/B + (D/C)/(B/A)

member(X, [X|_]) :- !.
member(X, [_|T]) :- member(X, T).

slice([], _, []).
slice([X|A], B, C) :- 
    member(X, B),
    !,                    
    slice(A, B, C).
slice([X|A], B, [X|C]) :-
    slice(A, B, C).

unite([], L, L).
unite([X|L1], L2, [X|L3]) :-
    unite(L1, L2, L3).

main(A, B, C, D, Result) :-
    slice(C, D, Tmp1),
    slice(Tmp1, B, Res1),
    
    slice(D, C, Tmp2),
    slice(B, A, Tmp3),
    slice(Tmp2, Tmp3, Res2), 
    
    unite(Res1, Res2, Result).

% main([9, 10, 6, 11, 12, 2, 13, 4, 5, 19, 20, 21], 
% [6, 7, 2, 1, 8, 4, 5, 3, 20, 21, 22, 23], 
% [17, 14, 18, 19, 13, 20, 4, 21, 5, 22, 23, 3], 
% [15, 16, 14, 13, 11, 12, 4, 2, 5, 3, 1], Result)
