person(name(murray, perse, pressley), date(31, 11, 1995)).
person(name(will, edward, ayers), date(26, 12, 1987)).
person(name(quincey, steven, haggard), date(21, 3, 1994)).
person(name(eustace, elroy, jordan), date(18, 8, 2001)).
person(name(craig, madison, briggs), date(15, 5, 1983)).

person(name(river, rosemary, dobson), date(8, 3, 1996)).
person(name(jasmyn, emmie, wragge), date(9, 12, 2002)).
person(name(lou, josepha, trueman), date(2, 6, 1993)).
person(name(deidra, tricia, dudley), date(22, 11, 1994)).
person(name(dayna, tawnee, dwight), date(3, 5, 2000)).

spouse(name(murray, perse, pressley), name(river, rosemary, dobson)).
spouse(name(will, edward, ayers), name(jasmyn, emmie, wragge)).
spouse(name(quincey, steven, haggard), name(lou, josepha, trueman)).
spouse(name(eustace, elroy, jordan), name(deidra, tricia, dudley)).
spouse(name(craig, madison, briggs), name(dayna, tawnee, dwight)).

initial_list(P, S) :-
    findall(person(Name, Date), person(Name, Date), Persons),
    findall(spouse(Name1, Name2), spouse(Name1, Name2), Spouses),
    append([], Persons, P),
    append([], Spouses, S).

try_name(person(Name, date(_, Mon, _)), TryName, AskedMon) :-
    Name = TryName,
    AskedMon is Mon, !.

try_name(_, _, AskedMon) :-
    AskedMon is 0.

mon([], _, 1).

mon([P|Persons], Name, Mon) :-
    try_name(P, Name, AskedMon),
    AskedMon = 0,
    mon(Persons, Name, Mon), !.

mon([P|_], Name, AskedMon) :-
    try_name(P, Name, AskedMon).

same_mon(Persons, spouse(Name1, Name2)) :-
    mon(Persons, Name1, Mon1),
    mon(Persons, Name2, Mon2),
    Mon1 = Mon2.

ans(_, [], []) :- !.    

ans(Persons, [S|Spouses], Ans) :-
    same_mon(Persons, S),
    ans(Persons, Spouses, Ans1),
    append(Ans1, [S], Ans), !.

ans(Persons, [_|Spouses], Ans) :-
    ans(Persons, Spouses, Ans).

work :-
    write("Please, do not use uppercase!"), nl,
    initial_list(P,S),
    add_q(Op, Os),
    append(P, Op, P1),
    append(S, Os, S1),
    ans(P1, S1, Ans),
    printlist(Ans).

add_q(P, S) :-
    write("Enter anything? (y/n):"),
    read(Ch),
    Ch = y,
   	add_obj(y, P, S),
    !.

add_q([], []) :- !.

add_obj(y, [Pobj|P], S) :-
    write("Enter person or spouse? (p/s):"),
    read(Ch),
    
	Ch = p, !,

    write("Enter First name: "),
    read(FirstName),
    write("Enter Middle name: "),
    read(MiddleName),
    write("Enter Last name: "),
    read(LastName),
    write("Enter BD day: "),
    read(Bday),
    write("Enter BD mon (number): "),
    read(Bmon),
    write("Enter BD year: "),
    read(Byear),

    Pobj = person(name(FirstName, MiddleName, LastName), date(Bday, Bmon, Byear)),
    
    write("Continue? (y/n): "),
    read(Val),
    add_obj(Val, P, S).

add_obj(y, P, [Sobj|S]) :-

    write("Enter husband's First name: "),
    read(FirstName1),
    write("Enter husband's Middle name: "),
    read(MiddleName1),
    write("Enter husband's Last name: "),
    read(LastName1),
    
    write("Enter wife's First name: "),
    read(FirstName2),
    write("Enter wife's Middle name: "),
    read(MiddleName2),
    write("Enter wife's Last name: "),
    read(LastName2),

    Sobj = spouse(name(FirstName1, MiddleName1, LastName1), name(FirstName2, MiddleName2, LastName2)),

    write("Continue? (y/n): "),
    read(Val),
    add_obj(Val, P, S),
    !.

add_obj(_, [], []) :- !.

printlist([]) :- !.
printlist([Sobj|S]) :-
    printobj(Sobj),
    printlist(S).

printobj(spouse(name(FirstName1, MiddleName1, LastName1), name(FirstName2, MiddleName2, LastName2))) :-
    print(FirstName1),
    write(" "),
    print(MiddleName1),
    write(" "),
    print(LastName1),
    write(" <-> "),
    print(FirstName2),
    write(" "),
    print(MiddleName2),
    write(" "),
    print(LastName2),
    nl.
    
% ?- work
