herramientasRequeridas(ordenarCuarto, [aspiradora(100), trapeador, plumero]).
herramientasRequeridas(limpiarTecho, [escoba, pala]).
herramientasRequeridas(cortarPasto, [bordedadora]).
herramientasRequeridas(limpiarBanio, [sopapa, trapeador]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).
herramientasRequeridas(encerarPisos, [lustradpesora, cera, aspiradora(300)]).

tiene(egon,aspiradora(200)).
tiene(egon,trapeador).
tiene(egon,plumero).
tiene(peter,trapeador).
tiene(winston,varita).

tareaPedida(ordenarCuarto, dana, 20).
tareaPedida(cortarPasto, walter, 50).
tareaPedida(limpiarTecho, walter, 70).
tareaPedida(limpiarBanio, louis, 15).
precio(ordenarCuarto, 13).
precio(limpiarTecho, 20).
precio(limpiarBanio, 55).
precio(cortarPasto, 10).
precio(encerarPisos, 7).

satisfacenecesidad(Integrante,Herramienta):-
tiene(Integrante,Herramienta),
Herramienta\=aspiradora(_).

satisfacenecesidad(Integrante,aspiradora(Potencia)):-
tiene(Integrante,aspiradora(Potenciaspiradora)),
Potenciaspiradora>=Potencia.

puederealizartarea(Integrante,Tarea):-
herramientasRequeridas(Tarea,_),
tiene(Integrante,varita).

puederealizartarea(Integrante,Tarea):-
    herramientasRequeridas(Tarea,Herramientasrequeridas),
    forall(member(Herramienta,Herramientasrequeridas),satisfacenecesidad(Integrante,Herramienta)).

precioacobrar(Cliente,PrecioTotal):-
findall(Precio,precioporunidad(_,Cliente,Precio),Precios),
sumlist(Precios,PrecioTotal).

precioporunidad(Tarea,Cliente,Precio):-
    tareaPedida(Tarea,Cliente,Metros),
    precio(Tarea,Preciopormetro),
    Precio is Metros*Preciopormetro.

aceptapedido(peter,_).

aceptapedido(ray,Cliente):-
not(tareaPedida(limpiarTecho,Cliente,_)).

aceptapedido(winston,Cliente):-
    precioacobrar(Cliente,PrecioTotal),
    PrecioTotal>500.

aceptapedido(egon,Cliente):-
   forall(tareaPedida(Tarea,Cliente,_),
    not(tareacompleja(Tarea))).

tareacompleja(Tarea):-
herramientasRequeridas(Tarea,Herramientas),
length(Herramientas,Tamanio),
Tamanio>2.
tareacompleja(limpiarTecho).
