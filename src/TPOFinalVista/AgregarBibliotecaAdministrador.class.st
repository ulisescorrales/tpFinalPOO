Class {
	#name : #AgregarBibliotecaAdministrador,
	#superclass : #Morph,
	#instVars : [
		'sistema',
		'id',
		'nombre',
		'direccion',
		'telefono',
		'representante',
		'tiempoDevolucion',
		'buttonCrear',
		'campos',
		'estado',
		'retroceder',
		'morphFormulario',
		'morphBibliotecasCargadas'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
AgregarBibliotecaAdministrador class >> crearConSistema:sistema [

|unMorph|
unMorph:=self new.
unMorph inicializarConSistema:sistema.
^unMorph.
]

{ #category : #'as yet unclassified' }
AgregarBibliotecaAdministrador >> botonRetroceder [ 
retroceder:=SimpleButtonMorph new.
retroceder label:'Retroceder'font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
self addMorph:retroceder.
retroceder bottomLeft:self bottomLeft -(-20@20).

retroceder target:[
	self hide.
	self owner cargarPantallaRolAdministrador  .
	].
retroceder actionSelector:#value. 
]

{ #category : #applying }
AgregarBibliotecaAdministrador >> comprobarCampos [

	| correcto |
	correcto:=false.
	id getCampo = ''
		ifFalse: [ 
			id getCampo isAllDigits
				ifTrue: [ "Si falta completar algún campo"
					nombre getCampo = '' | (direccion getCampo = '')
					| (telefono getCampo = '') | (representante getCampo = '')
					| (tiempoDevolucion getCampo = '')
						ifTrue: [ 
							estado contents: 'Falta completar campos'.
							estado right: morphFormulario  right. ]
						ifFalse: [ "Campo de tiempo de devolución tiene que ser un número"
							tiempoDevolucion getCampo isAllDigits
								ifTrue: [
									"Comprobar que el ID no existe"
									(sistema existeIdBiblioteca: ((id getCampo)asInteger))
									ifFalse: [correcto := true.
									estado contents: 'Biblioteca creada'.
									estado right: morphFormulario  right. ] 
								ifTrue:[
									estado contents:'Id ya existe'.
										estado right: morphFormulario  right
									].
									]
								ifFalse: [ 
									estado contents: 'Tiempo para devolución debe ser un número'.
									estado right: morphFormulario  right.
									] ] ]
				ifFalse: [ 
					estado contents: 'Id debe ser un número'.
					estado right: morphFormulario  right.] ]
		ifTrue: [ 
			estado contents: 'Id está vacío'.
			estado right: morphFormulario  right. ].


	^ correcto
]

{ #category : #initialize }
AgregarBibliotecaAdministrador >> inicializarConSistema:sistema2 [

sistema:=sistema2.

self width:1000.
self height:620.

self mostrarFormularioCrearBiblioteca .
self mostrarBibliotecasCargadas.

sistema addDependent:self.

self botonRetroceder .
]

{ #category : #'as yet unclassified' }
AgregarBibliotecaAdministrador >> mostrarBibliotecasCargadas [
|bibliotecas titulo fuente|

fuente := StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20.
bibliotecas:=sistema getBibliotecas.
morphBibliotecasCargadas := MenuMorph new.
morphBibliotecasCargadas stayUp: true.
titulo:= 'Bibliotecas cargadas' asStringMorph.
titulo font:fuente.

bibliotecas do:[:biblioteca|morphBibliotecasCargadas add:((biblioteca getId)asString,' - ',(biblioteca getNombre ))
	target:[]  selector:#value ].

self addMorph:morphBibliotecasCargadas .
self addMorph:titulo.
morphBibliotecasCargadas center: self center.
morphBibliotecasCargadas  left:morphBibliotecasCargadas left+100.
morphBibliotecasCargadas  top:morphFormulario top.
titulo bottomLeft:morphBibliotecasCargadas topLeft.
]

{ #category : #applying }
AgregarBibliotecaAdministrador >> mostrarFormularioCrearBiblioteca [
	campos := BorderedMorph new.
	morphFormulario := BorderedMorph new.
	id := EtiquetaCampo crearConEtiqueta: 'Id'.
	campos addMorph: id.
	id right:morphFormulario right.
	
	nombre := EtiquetaCampo crearConEtiqueta: 'Nombre'.
	campos addMorph: nombre.
	nombre topRight: id bottomRight.


	direccion := EtiquetaCampo crearConEtiqueta: 'Dirección'.
	campos addMorph: direccion.
	direccion topRight: nombre bottomRight.

	telefono := EtiquetaCampo crearConEtiqueta: 'Telefono'.
	campos addMorph: telefono.
	telefono topRight: direccion bottomRight.

	representante := EtiquetaCampo crearConEtiqueta: 'Representante'.
	campos addMorph: representante.
	representante topRight: telefono bottomRight.

	tiempoDevolucion := EtiquetaCampo crearConEtiqueta:
		                    'Tiempo para devolución (días)'.
	campos addMorph: tiempoDevolucion.
	tiempoDevolucion topRight: representante bottomRight.

	buttonCrear := SimpleButtonMorph new.
	buttonCrear
		label: 'Crear Biblioteca'
		font: (StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).

	buttonCrear target: [
		(self comprobarCampos) ifTrue:[(sistema
			         crearBibliotecaConid: id getCampo asInteger
			         direccion: direccion getCampo
			         nombre: nombre getCampo
			         telefono: telefono getCampo
			         representante: representante getCampo
			         tiempoDevolucion: tiempoDevolucion getCampo asInteger)
						ifTrue: [campos submorphs do: [ :m | m vaciarCampo ]
							].
			]].
	buttonCrear actionSelector: #value.

	estado := '' asStringMorph.
	
	morphFormulario addMorph:campos.
	self addMorph:buttonCrear.
	self addMorph:estado.
	
	self addMorph:morphFormulario.	
	
	buttonCrear center:self center.
	morphFormulario bottomRight: buttonCrear topRight.
	buttonCrear topRight:tiempoDevolucion bottomRight.
	
	morphFormulario position:morphFormulario position -(100@100).
	buttonCrear  position:buttonCrear  position -(100@100).
	
	estado center:self center.
	estado top:buttonCrear bottom.
	estado right: morphFormulario  right.
]

{ #category : #accessing }
AgregarBibliotecaAdministrador >> show [
estado ifNotNil:[estado contents:''].
super show
]

{ #category : #updating }
AgregarBibliotecaAdministrador >> update: ultimaBiblioteca [

	morphBibliotecasCargadas
		add:
		ultimaBiblioteca getId asString , ' - ' , ultimaBiblioteca getNombre
		target: [  ]
		selector: #value
]
