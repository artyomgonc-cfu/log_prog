person(name("Murray", "Perse", "Pressley"), date(31, 11, 1995)).
person(name("Will", "Edward", "Ayers"), date(26, 12, 1987)).
person(name("Quincey", "Steven", "Haggard"), date(21, 3, 1994)).
person(name("Eustace", "Elroy", "Jordan"), date(18, 8, 2001)).

person(name("River", "Rosemary", "Dobson"), date(8, 3, 1996)).
person(name("Jasmyn", "Emmie", "Wragge"), date(9, 12, 2002)).
person(name("Lou", "Josepha", "Trueman"), date(2, 6, 1993)).
person(name("Deidra", "Tricia", "Dudley"), date(22, 11, 1994)).

spouse(name("Murray", "Perse", "Pressley"), name("River", "Rosemary", "Dobson")).
spouse(name("Will", "Edward", "Ayers"), name("Jasmyn", "Emmie", "Wragge")).
spouse(name("Quincey", "Steven", "Haggard"), name("Lou", "Josepha", "Trueman")).
spouse(name("Eustace", "Elroy", "Jordan"), name("Deidra", "Tricia", "Dudley")).

initial_list(P, S) :-
    findall(person(Name, Date), person(Name, Date), Persons),
    findall(spouse(Name1, Name2), spouse(Name1, Name2), Spouses),
    append([], Persons, P),
    append([], Spouses, S).

try_name(person(Name, date(_, Mon, _)), TryName, AskedMon) :-
    Name = TryName,
    AskedMon is Mon, !.

try_name(P, Name, AskedMon) :-
    AskedMon is 0.

mon([], _, 1).

mon([P|Persons], Name, Mon) :-
    try_name(P, Name, AskedMon),
    AskedMon = 0,
    mon(Persons, Name, Mon), !.

mon([P|Persons], Name, AskedMon) :-
    try_name(P, Name, AskedMon).

same_mon(Persons, spouse(Name1, Name2)) :-
    mon(Persons, Name1, Mon1),
    mon(Persons, Name2, Mon2),
    Mon1 = Mon2.

ans(_, [], []) :- !.    

ans(Persons, [S|Spouses], Ans) :-
    same_mon(Persons, S),
    ans(Persons, Spouses, Ans1),
    append(Ans1, S, Ans), !.

ans(Persons, [S|Spouses], Ans) :-
    ans(Persons, Spouses, Ans),

work :-
    initial_list(P,S), ans(P, S, Ans), print(Ans).

same_mon(H, W) :-
    spouse(H, W), person(H, date(_, D, _)), person(W, date(_, D, _)).

new_list(List) :-
    findall(spouse(Name1, Name2), same_mon(Name1, Name2), List).



add_person(y) :-
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
    assertz(person(name(FirstName, MiddleName, LastName), date(Bday, Bmon, Byear))),
    write("Continue? (y/n): "),
    read(val),
    add_person(val).
