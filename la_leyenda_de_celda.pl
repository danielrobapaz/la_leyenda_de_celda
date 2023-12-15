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

% LECTURA DE ARCHIVOS
leer(X) :- read(MapPath), see(MapPath), read(X), seen.

% INTERACTIVIDAD CON EL USUARIO

inicio :-
    write('Hey, listen! Hiperlink, rápido, ¿Dónde está el mapa?: '),
    leer(Mapa),
    menu_principal(Mapa).

menu_principal(Mapa) :-
    write('¿Qué quieres hacer con el mapa? 1. Cruzar 2. Verificar si es siempre seguro: '),
    read(Opcion),
    (Opcion == 1 -> menu_cruzar(Mapa); siempre_seguro(Mapa)).

menu_cruzar(Mapa) :-
    write('¿Quieres dar un conjunto de palancas y ver el resultado, o ver las palancas que llevan a un estado? 1. Dar conjunto de palancas 2. Dar estado final: '),
    read(Opcion),
    (Opcion == 1 -> dar_palancas(Mapa); ver_palancas(Mapa)).

dar_palancas(Mapa) :-
    write('Por favor, introduce el conjunto de palancas: '),
    read(Palancas),
    cruzar(Mapa, Palancas, Resultado),
    (Resultado == true -> write('Es seguro cruzar con estas palancas :)'); write('No es seguro cruzar, ¡Cuidado, Hyperlink! D:')).

ver_palancas(Mapa) :-
    write('¿Quieres ver las palancas que llevan a un estado seguro o a una trampa? 1. Seguro 2. Trampa: '),
    read(Opcion),
    (Opcion == 1 -> cruzar(Mapa, P, seguro); cruzar(Mapa, P, trampa)),
    write(P).