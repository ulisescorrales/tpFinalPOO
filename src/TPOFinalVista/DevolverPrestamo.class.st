Class {
	#name : #DevolverPrestamo,
	#superclass : #BorderedMorph,
	#instVars : [
		'sistema',
		'usuario',
		'estado',
		'retroceder'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
DevolverPrestamo class >> crearConSistema: unSistema conUsuario: unUsuario [

|unMorph|
unMorph:= self new.
unMorph inicializarConSistema: unSistema conUsuario: unUsuario.
^unMorph 
]

{ #category : #'as yet unclassified' }
DevolverPrestamo >> botonRetroceder [ 
retroceder:=SimpleButtonMorph new.
retroceder label:'Volver a Opciones'font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
self addMorph:retroceder.
retroceder bottomLeft:self bottomLeft -(-20@20).

retroceder target:[
	self hide.
	self owner cargarOpcionesUsuario .
	].
retroceder actionSelector:#value.
]

{ #category : #initialize }
DevolverPrestamo >> inicializarConSistema: unSistema conUsuario: unUsuario [

sistema:=unSistema.
usuario :=unUsuario .

self width: 1000.
self height:620.

self mostrarDevolverPrestamo .



]

{ #category : #applying }
DevolverPrestamo >> mostrarDevolverPrestamo [

|bibliotecas titulo menuBibliotecas suspendido|

titulo :='Seleccionar biblioteca para devolver el préstamo activo en:' asStringMorph .
titulo font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .
self addMorph:titulo.
"Bibliotecas con préstamo activo"
bibliotecas := usuario getBibliotecasConPrestamoActivo.

menuBibliotecas :=MenuMorph new.
menuBibliotecas stayUp: true.
self addMorph:menuBibliotecas.
bibliotecas do:[:biblioteca|
	menuBibliotecas add:(biblioteca getId)asString,'-',(biblioteca getNombre)
	target:[
		biblioteca devolverPrestamo: usuario.
		suspendido:=usuario estaSuspendido .
		estado contents:'Se ha devuelto el préstamo correctamente en ',biblioteca getNombre, ' con suspensión:	',suspendido asString.
		estado center:self center.
		estado top:menuBibliotecas bottom +20.
		menuBibliotecas selectedItem delete.
		]
	selector:#value.
	].

menuBibliotecas center:self center.
titulo center:self center.
titulo bottom:menuBibliotecas top -10.

estado:='' asStringMorph.
self addMorph:estado.

self botonRetroceder .
]
