Class {
	#name : #SeleccionarVerBiblioteca,
	#superclass : #Morph,
	#instVars : [
		'sistema',
		'titulo',
		'morphMenu',
		'retroceder',
		'tipoUsuario'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
SeleccionarVerBiblioteca class >> crearSeleccionarVerBibliotecaConSistema:unSistema [

|unMorph|
unMorph:=self new.
unMorph inicializarConSistema: unSistema.
^unMorph.
]

{ #category : #'as yet unclassified' }
SeleccionarVerBiblioteca >> botonRetroceder [

	retroceder := SimpleButtonMorph new.
	retroceder
		label: 'Volver al menú'
		font: (StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
	self addMorph: retroceder.
	retroceder bottomLeft: self bottomLeft - (-20 @ 20).

	retroceder target: [ 
		self hide.
		self owner cargarPantallaRolAdministrador . 
		 ].
	retroceder actionSelector: #value
]

{ #category : #initialization }
SeleccionarVerBiblioteca >> inicializarConSistema: unSistema [

sistema :=unSistema .
sistema addDependent:self.

self width:1000.
self height:620.
self verInformacionDeBibliotecas.
self botonRetroceder.   
]

{ #category : #updating }
SeleccionarVerBiblioteca >> update:unaBiblioteca [
morphMenu add:(unaBiblioteca getId)asString,'-',(unaBiblioteca getNombre)
	target:[self owner mostrarBiblioteca:unaBiblioteca] selector:#value
]

{ #category : #'as yet unclassified' }
SeleccionarVerBiblioteca >> verInformacionDeBibliotecas [
|  bibliotecas fuente |
fuente:=(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .
titulo:='Seleccione una biblioteca:'asStringMorph .
titulo font:fuente.

self addMorph:titulo.
titulo center:self center -(0@280).

morphMenu:=MenuMorph new.
morphMenu stayUp:true .
morphMenu width:150.
self addMorph:morphMenu.
morphMenu topLeft: titulo bottomLeft .

bibliotecas:= sistema getBibliotecas.
bibliotecas do:[:biblioteca|morphMenu add:(biblioteca getId)asString,'-',(biblioteca getNombre)
	target:[self owner mostrarBiblioteca:biblioteca] selector:#value].


]
