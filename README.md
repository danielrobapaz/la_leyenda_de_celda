Daniel Robayo\
Santiago Finamore\
Jorge Correia\
Valeria Vera

# la_leyenda_de_celda

Proyecto "La Leyenda de Celda" para CI3661.

## Implementación

`pasillo(X, Modo)`: Un pasillo del laberinto, donde X es la letra asociada al pasillo (Por ejemplo: a, b, c, etc.) y Modo corresponde a que el caracter est e regular o de cabeza (regular y de cabeza, respectivamente). Para poder cruzar este pasillo, la palanca correspondiente al caracter en X debe estar arriba (si Modo es regular) o abajo (si Modo es de cabeza).

`junta(SubMapa1, SubMapa2)`: Es la secuencia de dos submapas. Para poder cruzar esta junta, debe poder cruzarse primero SubMapa1 y luego, igualmente, SubMapa2.

`bifurcación(SubMapa1, SubMapa2)`: Es la bifurcaci ́on del camino en dos mapas. Para poder cruzar esta bifurcación, basta con poder cruzar SubMapa1 o, equivalentemente, SubMapa2.

`Palancas`: lista de asociaciones (pares ordenados) de la forma `(X, Posicion)`. Donde, X es cada una de las letras que aparecen en Mapa y Posicion es la posici on de la palanca correspondiente a la letra en X, que puede ser arriba o abajo.

`Seguro`: `seguro` si existe alguna manera de cruzar el laberinto o `trampa` de lo contrario.

## Modo de Uso
Ejecutar el comando `inicio.` previamente a cada movimiento.
