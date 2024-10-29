Class {
	#name : #OpcionesUsuario,
	#superclass : #Morph,
	#instVars : [
		'sistema',
		'usuario',
		'retroceder',
		'titulo',
		'buttonAgregarBiblioteca',
		'buttonPedirPrestamo',
		'buttonDevolverPrestamo'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
OpcionesUsuario class >> crearOpcionesUsuarioConUsuario:elUsuario conSistema:elSistema [

|unMorph|
unMorph:=self new.
unMorph inicializarOpcionesUsuarioConUsuario:elUsuario conSistema:elSistema.
^unMorph.
]

{ #category : #'as yet unclassified' }
OpcionesUsuario >> botonRetroceder [ 
retroceder:=SimpleButtonMorph new.
retroceder label:'Cerrar sesión'font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
self addMorph:retroceder.
retroceder bottomLeft:self bottomLeft -(-20@20).

retroceder target:[
	self hide.
	self owner cargarPantallaRolUsuario .
	].
retroceder actionSelector:#value.

]

{ #category : #'as yet unclassified' }
OpcionesUsuario >> cargarTitulo [

titulo ifNotNil: [ titulo delete ].
titulo:=('Usuario:',(usuario getApellido),' ',(usuario  getNombre))asStringMorph.
titulo font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
self addMorph:titulo.
titulo center:self center.
titulo top:self top+20.
]

{ #category : #'as yet unclassified' }
OpcionesUsuario >> inicializarOpcionesUsuarioConUsuario:elUsuario conSistema:elSistema [.
usuario:=elUsuario.
sistema:=elSistema .

self width: 1000.
self height: 620.

self mostrarOpciones
]

{ #category : #'as yet unclassified' }
OpcionesUsuario >> mostrarOpciones [
|  fuente|

self submorphs do:[:m|m delete].


self cargarTitulo.

fuente:=(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).

buttonPedirPrestamo:=SimpleButtonMorph new.
buttonPedirPrestamo label:'Pedir Préstamo'font:fuente.

buttonDevolverPrestamo:=SimpleButtonMorph new. 
buttonDevolverPrestamo  label:'Devolver Préstamo'font:fuente.

buttonAgregarBiblioteca:=SimpleButtonMorph new.
buttonAgregarBiblioteca label:'Agregar Biblioteca' font:fuente.

self addMorph:buttonPedirPrestamo.
self addMorph:buttonDevolverPrestamo.
self addMorph:buttonAgregarBiblioteca.

buttonAgregarBiblioteca center:self center.
buttonAgregarBiblioteca top:self top+250.

buttonPedirPrestamo topLeft:buttonAgregarBiblioteca bottomLeft +(0@20).
buttonPedirPrestamo width:buttonAgregarBiblioteca width.
buttonDevolverPrestamo   topLeft:buttonPedirPrestamo bottomLeft +(0@20).
buttonDevolverPrestamo  width:buttonAgregarBiblioteca width.

buttonAgregarBiblioteca target:[
	self hide.
	self owner cargarAgregarBibliotecaUsuario:usuario.	
	];
actionSelector:#value.


buttonPedirPrestamo target:[
	self hide.
	self owner cargarPedirPrestamoConUsuario:usuario.
	].
buttonPedirPrestamo actionSelector:#value.

buttonDevolverPrestamo target:[
	self hide.
	self owner cargarDevolverPrestamoConUsuario:usuario.
	].
buttonDevolverPrestamo actionSelector: #value.

self botonRetroceder .
]

{ #category : #'as yet unclassified' }
OpcionesUsuario >> reiniciarBotones [
buttonAgregarBiblioteca target:[
	self hide.
	self owner cargarAgregarBibliotecaUsuario:usuario.			
	];
actionSelector:#value.

buttonPedirPrestamo target:[
	self hide.
	self owner cargarPedirPrestamoConUsuario:usuario.
	].
buttonPedirPrestamo actionSelector:#value.

buttonDevolverPrestamo target:[
	self hide.
	self owner cargarDevolverPrestamoConUsuario:usuario.
	].
buttonDevolverPrestamo actionSelector: #value.
]

{ #category : #initialization }
OpcionesUsuario >> setUsuario:unUsuario [
usuario :=unUsuario .

]

{ #category : #showing }
OpcionesUsuario >> show:elUsuario [
self show.
(usuario==elUsuario) ifFalse: [ self setUsuario:elUsuario.
	 self cargarTitulo.	
	self owner reiniciarPantallasUsuario.
	self reiniciarBotones.
	].
]
