person(name("Murray", "Perse", "Pressley"), date(31, 11, 1995)).
person(name("Will", "Edward", "Ayers"), date(26, 12, 1987)).
person(name("Quincey", "Steven", "Haggard"), date(21, 3, 1994)).
person(name("Eustace", "Elroy", "Jordan"), date(18, 8, 2001)).
person(name("Craig", "Madison", "Briggs"), date(15, 5, 1983)).

person(name("River", "Rosemary", "Dobson"), date(8, 3, 1996)).
person(name("Jasmyn", "Emmie", "Wragge"), date(9, 12, 2002)).
person(name("Lou", "Josepha", "Trueman"), date(2, 6, 1993)).
person(name("Deidra", "Tricia", "Dudley"), date(22, 11, 1994)).
person(name("Dayna", "Tawnee", "Dwight"), date(3, 5, 2000)).

spouse(name("Murray", "Perse", "Pressley"), name("River", "Rosemary", "Dobson")).
spouse(name("Will", "Edward", "Ayers"), name("Jasmyn", "Emmie", "Wragge")).
spouse(name("Quincey", "Steven", "Haggard"), name("Lou", "Josepha", "Trueman")).
spouse(name("Eustace", "Elroy", "Jordan"), name("Deidra", "Tricia", "Dudley")).
spouse(name("Craig", "Madison", "Briggs"), name("Dayna", "Tawnee", "Dwight")).

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
    initial_list(P,S),
    add_q(P, S, Op, Os),
    print(Op), print(Os),
    ans(Op, Os, Ans),
    print(Ans).

add_q(P, S, Op, Os) :-
    Op = P, Os = S,
    write("Enter anything? (y/n):"),
    read(Ch),
    Ch = y,
   	add_obj(y, Op, Os, Nop, Nos),
    Op is Nop, Os is Nos,
    !.

add_q(P, S, P, S) :- !.

add_obj(y, Op, Os, Nop, Nos) :-
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

    append(Op, [person(name(FirstName, MiddleName, LastName), date(Bday, Bmon, Byear))], Nop),

    write("Continue? (y/n): "),
    read(Val),
    add_obj(Val, Nop, Os, Nop1, Nos),
    Nop is Nop1.

add_obj(y, Op, Os, Nop, Nos) :-

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

    append(Os, [spouse(name(FirstName1, MiddleName1, LastName1), name(FirstName2, MiddleName2, LastName2))], Nos),

    write("Continue? (y/n): "),
    read(Val),
    add_obj(Val, Op, Nos, Nop, Nos1),
    Nos is Nos1.
