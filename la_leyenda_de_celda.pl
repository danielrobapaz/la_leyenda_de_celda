pasillo_cruzable(NombrePasillo, Palancas, Palanca) :- 
    member((NombrePasillo, Palanca), Palancas), !.

limpiar([], []).
limpiar([Hx|Tx], [Hx|Ty]) :- nonvar(Hx), limpiar(Tx, Ty),!.
limpiar([Hx|_], []) :- var(Hx).

hay_palancas_duplicadas(Palancas) :-
    member((X, arriba), Palancas),
    member((X, abajo), Palancas), !.

cruzar(Mapa, Palancas, Seguro) :- 
    cruzar_por_casos(Mapa, Palancas_Limpias, Seguro),
    limpiar(Palancas_Limpias, Palancas),
    not(hay_palancas_duplicadas(Palancas)).

% CASOS PARA PASILLOS
cruzar_por_casos(pasillo(Pasillo, regular), Palancas, seguro) :-
    pasillo_cruzable(Pasillo, Palancas, arriba).

cruzar_por_casos(pasillo(Pasillo, de_cabeza), Palancas, seguro) :- 
    pasillo_cruzable(Pasillo, Palancas, abajo).

cruzar_por_casos(pasillo(Pasillo, regular), Palancas, trampa) :- 
    pasillo_cruzable(Pasillo, Palancas, abajo).

cruzar_por_casos(pasillo(Pasillo, de_cabeza), Palancas, trampa) :- 
    pasillo_cruzable(Pasillo, Palancas, arriba).


% CASOS PARA JUNTA
cruzar_por_casos(junta(Sub_Mapa_1, Sub_Mapa_2), Palancas, seguro) :-
    cruzar_por_casos(Sub_Mapa_1, Palancas, seguro),
    cruzar_por_casos(Sub_Mapa_2, Palancas, seguro).

cruzar_por_casos(junta(Sub_Mapa_1, Sub_Mapa_2), Palancas, trampa) :-
    cruzar_por_casos(Sub_Mapa_1, Palancas, trampa),
    cruzar_por_casos(Sub_Mapa_2, Palancas, seguro).

cruzar_por_casos(junta(Sub_Mapa_1, Sub_Mapa_2), Palancas, trampa) :-
    cruzar_por_casos(Sub_Mapa_1, Palancas, seguro),
    cruzar_por_casos(Sub_Mapa_2, Palancas, trampa).

cruzar_por_casos(junta(Sub_Mapa_1, Sub_Mapa_2), Palancas, trampa) :-
    cruzar_por_casos(Sub_Mapa_1, Palancas, trampa),
    cruzar_por_casos(Sub_Mapa_2, Palancas, trampa).

% CASOS PARA BIFURCACION    
cruzar_por_casos(bifurcacion(Sub_Mapa_1, Sub_Mapa_2), Palancas, seguro) :-
    cruzar_por_casos(Sub_Mapa_1, Palancas, seguro),
    cruzar_por_casos(Sub_Mapa_2, Palancas, seguro).

cruzar_por_casos(bifurcacion(Sub_Mapa_1, Sub_Mapa_2), Palancas, seguro) :-
    cruzar_por_casos(Sub_Mapa_1, Palancas, seguro),
    cruzar_por_casos(Sub_Mapa_2, Palancas, trampa).

cruzar_por_casos(bifurcacion(Sub_Mapa_1, Sub_Mapa_2), Palancas, seguro) :-
    cruzar_por_casos(Sub_Mapa_1, Palancas, trampa),
    cruzar_por_casos(Sub_Mapa_2, Palancas, seguro).

cruzar_por_casos(bifurcacion(Sub_Mapa_1, Sub_Mapa_2), Palancas, trampa) :-
    cruzar_por_casos(Sub_Mapa_1, Palancas, trampa),
    cruzar_por_casos(Sub_Mapa_2, Palancas, trampa).

% SECCION SIEMPRE SEGURO

siempre_seguro(Mapa) :- \+(cruzar(Mapa, _, trampa)).