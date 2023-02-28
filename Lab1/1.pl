% A is grandson of B
grandson(A, B) :-
    parent(Z, A),
    parent(B, Z),
    man(A).

woman(flora).
woman(julia).
woman(fiona).

man(brand).
man(blaze).
man(jean).
man(paul).

parent(julia, fiona).
parent(paul, fiona).
parent(fiona, flora).
parent(fiona, jean).
parent(flora, blaze).
parent(blaze, brand).

%?- grandson(Grandson, Grandparent)
