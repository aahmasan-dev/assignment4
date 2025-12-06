% Team: Irtifaur Rahman, Kareem Ahmasani, Mary-Angel Sannapu

% facts
male(onrun).
male(baby).
male(i).
male(dad).
female(redhair).
female(widow).
spouse(i, widow).
spouse(dad, redhair).
biological_parent(i, baby).
biological_parent(dad, i).
biological_parent(widow, redhair).
biological_parent(dad, onrun).
biological_parent(redhair, onrun).
biological_parent(widow, baby).


 

% rules

% parents and step parents
parent(X,Y):- 
    biological_parent(X,Y);
    step_parent(X,Y).
step_parent(X,Y):- 
    married(X,Z),
    biological_parent(Z,Y).

% parents and children

wife(X,Y):-
    married(X,Y),
    female(X).

husband(X,Y):-
    married(X,Y),
    male(X).

father(X,Y):- 
    parent(X,Y), 
    male(X). 

mother(X,Y):-
    parent(X, Y),
    female(X).

son(X, Y) :-
        parent(Y, X),
        male(X).

daughter(X, Y) :-
        parent(Y, X),
        female(X).

% siblings

sibling(X, Y) :-
        parent(Z, X),
        parent(Z, Y),
	X \= Y.

brother(X, Y) :-
        sibling(X, Y),
        male(X).

sister(X, Y) :-
        sibling(X, Y),
        female(X).

son_in_law(X, Y) :-
        married(X, Z),
        parent(Y, Z),
        male(X).

sibling_in_law(X, Y) :-
        married(X, Z), sibling(Z, Y);
        married(Y, Z), sibling(Z, X).

% uncle and aunt

uncle_aunt(X, Y) :-
        sibling(X, Z),
        parent(Z, Y).

uncle(X, Y) :-
        uncle_aunt(X, Y),
        male(X).

aunt(X, Y) :-
    uncle_aunt(X, Y),
    female(X).
% grandparents and grandchild

grandparent(X, Z) :-
        parent(X, Y),
        parent(Y, Z).

grandmother(X, Y) :-
        grandparent(X, Y),
        female(X).

grandfather(X, Y) :-
        grandparent(X, Y),
        male(X).

grandchild(X, Y) :-
        grandparent(Y, X).

% married

married(X,Y) :- spouse(X,Y).
married(X,Y) :- spouse(Y,X).


check(Goal, YesMsg, NoMsg) :-
    (Goal -> write(YesMsg) ; write(NoMsg)), nl.

% output
runIt :-
    check(daughter(redhair, i), 'Is redhair the daughter of i?: Yes', 'Is redhair the daughter of i?: No'),
    check(mother(redhair, i), 'Is redhair the mother of i?: Yes', 'Is redhair the mother of i?: No'),
    check(son_in_law(dad, i), 'Is dad the son in law of i?: Yes', 'Is dad the son in law of i?: No'),
    check(brother(baby, dad), 'Is baby the brother of dad?: Yes', 'Is baby the brother of dad?: No'),
    check(uncle(baby, i), 'Is baby the uncle of i?: Yes', 'Is baby the uncle of i?: No'),
    check(brother(baby, redhair), 'Is baby the brother of redhair?: Yes', 'Is baby the brother of redhair?: No'),
    check(grandchild(onrun, i), 'Is onrun the grandchild of i?: Yes', 'Is onrun the grandchild of i?: No'),
    check(mother(widow, redhair), 'Is widow the mother of redhair?: Yes', 'Is widow the mother of redhair?: No'),
    check(grandmother(widow, i), 'Is widow the grandmother of i?: Yes', 'Is widow the grandmother of i?: No'),
    check(grandchild(i, widow), 'Is i the grandchild of widow?: Yes', 'Is i the grandchild of widow?: No'),
    check(grandfather(i, i), 'Is i the grandfather of i: Yes', 'Is i the grandfather of i: No').





