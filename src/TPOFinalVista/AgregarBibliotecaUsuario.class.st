Class {
	#name : #AgregarBibliotecaUsuario,
	#superclass : #BorderedMorph,
	#instVars : [
		'sistema',
		'usuario',
		'estado',
		'retroceder',
		'morphMenuI',
		'morphMenuD'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
AgregarBibliotecaUsuario class >> crearConSistema:unSistema conUsuario:unUsuario [

|unMorph|
unMorph:=self new.
unMorph inicializarConSistema: unSistema conUsuario: unUsuario.
^unMorph
]

{ #category : #'as yet unclassified' }
AgregarBibliotecaUsuario >> botonRetroceder [ 
retroceder := SimpleButtonMorph new.
	retroceder
		label: 'Volver a Opciones'
		font: (StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
	self addMorph: retroceder.
	retroceder bottomLeft: self bottomLeft - (-20 @ 20).

	retroceder target: [ 
		self hide.
		"El usuario no cambia"
		self owner cargarOpcionesUsuario].
	retroceder actionSelector: #value.

]

{ #category : #initialize }
AgregarBibliotecaUsuario >> inicializarConSistema:unSistema conUsuario:unUsuario [

self width:1000.
self height:620.

usuario:=unUsuario .
sistema:=unSistema .

sistema addDependent:self.

self mostrarAgregarBiblioteca .
]

{ #category : #applying }
AgregarBibliotecaUsuario >> mostrarAgregarBiblioteca [

	| bibliotecasUsuario bibliotecasSinCargar colBibliotecasAgregar  agregar quitar aceptar b fuente titulo1 titulo2 colBibliotecas |
	fuente := StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20.
	morphMenuI := MenuMorph new.
	morphMenuD := MenuMorph new.
	self addMorph: morphMenuI.
	self addMorph: morphMenuD.
	morphMenuI center: self center - (250 @ 0).
	morphMenuD center: self center + (250 @ 0).
	morphMenuI stayUp: true.
	morphMenuD stayUp: true.
	"Bibliotecas para cargar"
	colBibliotecasAgregar:=OrderedCollection new.
	"Clonar la colección de bibliotecas del sistema"
	bibliotecasSinCargar  := OrderedCollection new.
	sistema getBibliotecas do: [ :bib | bibliotecasSinCargar addFirst: bib ].
	"Bibliotecas que no estan cargadas por el usuario"
	bibliotecasUsuario := usuario getBibliotecas.
	bibliotecasUsuario do: [ :biblioteca | 
		bibliotecasSinCargar remove: biblioteca ].
	"Mostrar en el menú izquierdo"
	bibliotecasSinCargar do: [ :biblioteca | 
		morphMenuI
			add: biblioteca getId asString , '-' , biblioteca getNombre
			target: [ morphMenuI selectedItem isSelected: true.
				estado ifNotNil: [ estado delete ].
				.
				 ]
			selector: #value ].
	"Mostrar en el menú derecho"
	bibliotecasUsuario do: [ :biblioteca | 
		morphMenuD
			add: biblioteca getId asString , '-' , biblioteca getNombre
			target: [ 
				morphMenuD selectedItem isSelected: true.
				estado ifNotNil: [ estado delete ] ]
			selector: #value ].

	agregar := SimpleButtonMorph new.
	agregar label: 'Agregar ->' font: fuente.
	self addMorph: agregar.
	quitar := SimpleButtonMorph new.
	quitar label: '<- Quitar' font: fuente.
	self addMorph: quitar.

	agregar center: self center.
	agregar position: agregar position - (0 @ 20).
	agregar target: [ 
		morphMenuI selectedItem ifNotNil: [ 
			morphMenuD
				add: morphMenuI selectedItem contents
				target: [ morphMenuD selectedItem isSelected: true.
					estado ifNotNil: [ estado delete ] ]
				selector: #value.
			morphMenuI selectedItem delete.
			morphMenuI selectItem: nil event: [  ] ] ].
	agregar actionSelector: #value.

	quitar width: agregar width.
	quitar center: self center.
	quitar position: quitar position + (0 @ 20).
	quitar target: [ 
		morphMenuD selectedItem ifNotNil: [ 
			morphMenuI
				add: morphMenuD selectedItem contents
				target: [ morphMenuI selectedItem isSelected: true.
					estado ifNotNil: [ estado delete ] ]
				selector: #value.
			morphMenuD selectedItem delete.
			morphMenuD selectItem: nil event: [  ] ] ].
	quitar actionSelector: #value.

	aceptar := SimpleButtonMorph new.
	aceptar label: 'Aceptar' font: fuente.
	self addMorph: aceptar.
	aceptar center: self center.
	aceptar top: quitar bottom + 20.
	aceptar target: [ 
		estado ifNotNil: [ estado delete ].
		estado := 'Bibliotecas agregadas correctamente' asStringMorph.
		self addMorph: estado.
		estado center: self center.
		estado top: aceptar bottom.
		estado contents: ''.
		colBibliotecas := OrderedCollection new.
		morphMenuD submorphs do: [ :m | 
			b := sistema getBiblioteca:
				     ((m contents asString substrings: '-') at: 1) asInteger.
			colBibliotecas addFirst: b ].
		estado contents: 'Bibliotecas agregadas correctamente'.
		usuario setBibliotecas: colBibliotecas ].
	aceptar actionSelector: #value.

	self botonRetroceder .
	
	titulo1 := 'Bibliotecas existentes:' asStringMorph.
	titulo2 := 'Bibliotecas favoritas:' asStringMorph.
	self addMorph: titulo1.
	self addMorph: titulo2.
	titulo1 bottomLeft: morphMenuI topLeft - (0 @ 10).
	titulo2 bottomLeft: morphMenuD topLeft - (0 @ 10)
]

{ #category : #accessing }
AgregarBibliotecaUsuario >> show [
super show.
estado ifNotNil:[estado delete].
]

{ #category : #updating }
AgregarBibliotecaUsuario >> update:unaBiblioteca [
morphMenuI
			add: unaBiblioteca getId asString , '-' , unaBiblioteca getNombre
			target: [ morphMenuI selectedItem isSelected: true.
				estado ifNotNil: [ estado delete ].
				.
				 ]
			selector: #value.
]
