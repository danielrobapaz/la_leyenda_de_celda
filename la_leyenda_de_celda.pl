pasillo_cruzable(NombrePasillo, Palancas, Palanca) :- 
    member((NombrePasillo, Palanca), Palancas), !.

limpiar([], []).
limpiar([Hx|Tx], [Hx|Ty]) :- nonvar(Hx), limpiar(Tx, Ty),!.
limpiar([Hx|_], []) :- var(Hx).

hay_palancas_duplicadas(Palancas) :-
    member((X, arriba), Palancas),
    member((X, abajo), Palancas), !.

cruzar(Mapa, Palancas, Seguro) :- 
    cruzarPorCasos(Mapa, PalancasLimpias, Seguro),
    limpiar(PalancasLimpias, Palancas),
    not(hay_palancas_duplicadas(Palancas)).

% CASOS PARA PASILLOS
cruzarPorCasos(pasillo(Pasillo, regular), Palancas, seguro) :-
    pasillo_cruzable(Pasillo, Palancas, arriba).

cruzarPorCasos(pasillo(Pasillo, de_cabeza), Palancas, seguro) :- 
    pasillo_cruzable(Pasillo, Palancas, abajo).

cruzarPorCasos(pasillo(Pasillo, regular), Palancas, trampa) :- 
    pasillo_cruzable(Pasillo, Palancas, abajo).

cruzarPorCasos(pasillo(Pasillo, de_cabeza), Palancas, trampa) :- 
    pasillo_cruzable(Pasillo, Palancas, arriba).


% CASOS PARA JUNTA
cruzarPorCasos(junta(SubMapa1, SubMapa2), Palancas, seguro) :-
    cruzarPorCasos(SubMapa1, Palancas, seguro),
    cruzarPorCasos(SubMapa2, Palancas, seguro).

cruzarPorCasos(junta(SubMapa1, SubMapa2), Palancas, trampa) :-
    cruzarPorCasos(SubMapa1, Palancas, trampa),
    cruzarPorCasos(SubMapa2, Palancas, seguro).

cruzarPorCasos(junta(SubMapa1, SubMapa2), Palancas, trampa) :-
    cruzarPorCasos(SubMapa1, Palancas, seguro),
    cruzarPorCasos(SubMapa2, Palancas, trampa).

cruzarPorCasos(junta(SubMapa1, SubMapa2), Palancas, trampa) :-
    cruzarPorCasos(SubMapa1, Palancas, trampa),
    cruzarPorCasos(SubMapa2, Palancas, trampa).

% CASOS PARA BIFURCACION    
cruzarPorCasos(bifurcacion(SubMapa1, SubMapa2), Palancas, seguro) :-
    cruzarPorCasos(SubMapa1, Palancas, seguro),
    cruzarPorCasos(SubMapa2, Palancas, seguro).

cruzarPorCasos(bifurcacion(SubMapa1, SubMapa2), Palancas, seguro) :-
    cruzarPorCasos(SubMapa1, Palancas, seguro),
    cruzarPorCasos(SubMapa2, Palancas, trampa).

cruzarPorCasos(bifurcacion(SubMapa1, SubMapa2), Palancas, seguro) :-
    cruzarPorCasos(SubMapa1, Palancas, trampa),
    cruzarPorCasos(SubMapa2, Palancas, seguro).

cruzarPorCasos(bifurcacion(SubMapa1, SubMapa2), Palancas, trampa) :-
    cruzarPorCasos(SubMapa1, Palancas, trampa),
    cruzarPorCasos(SubMapa2, Palancas, trampa).