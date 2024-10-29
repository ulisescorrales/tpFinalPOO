Class {
	#name : #PagarUsuarioPlus,
	#superclass : #BorderedMorph,
	#instVars : [
		'sistema',
		'retroceder',
		'estado'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
PagarUsuarioPlus class >> crearConSistema:unSistema [

|unMorph|
unMorph:=self new.
unMorph inicializarConSistema:unSistema.
^unMorph.
]

{ #category : #'as yet unclassified' }
PagarUsuarioPlus >> botonRetroceder [ 
	retroceder := SimpleButtonMorph new.
	retroceder
		label: 'Salir'
		font: (StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
	self addMorph: retroceder.
	retroceder bottomLeft: self bottomLeft - (-20 @ 20).

	retroceder target: [
		self hide.
		 self owner cargarPantallaRolAdministrador  ].
	retroceder actionSelector: #value.
]

{ #category : #initialization }
PagarUsuarioPlus >> inicializarConSistema: unSistema [

	| menuUsuarios buttonPagar titulo usuariosPlus elUsuario |
	sistema := unSistema.
	self width: 1000.
	self height: 620.

	titulo := 'Seleccione un usuario Plus para pagar:' asStringMorph.
	titulo font: (StrikeFont familyName: 'Bitmap DejaVu Sans' size: 16).
	self addMorph: titulo.

	buttonPagar := SimpleButtonMorph new.
	buttonPagar
		label: 'Aceptar pago'
		font: (StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
	self addMorph: buttonPagar.

	menuUsuarios := MenuMorph new.
	self addMorph: menuUsuarios.
	menuUsuarios stayUp: true.

	estado := ''asStringMorph .
	estado font: (StrikeFont familyName: 'Bitmap DejaVu Sans' size: 16).
	self addMorph:estado.

	usuariosPlus := sistema getUsuariosPlus.

	usuariosPlus do: [ :usuario | 
		menuUsuarios
			add: usuario getDNI asString , '-' , usuario getApellido , ' '
				, usuario getNombre
			target: [ 
				menuUsuarios selectedItem isSelected: true.
				elUsuario := usuario ]
			selector: #value ].

	titulo center: self center - (0 @ 50).
	menuUsuarios topLeft: titulo bottomLeft + (20 @ 0).
	menuUsuarios top: titulo bottom + 10.
	buttonPagar center: self center.
	buttonPagar top: menuUsuarios bottom + 10.
	
	self botonRetroceder .
	
	buttonPagar target: [ 
		elUsuario ifNotNil: [ 
			(elUsuario pagarCuota)
				ifTrue: [ 
					estado contents: 'Cuota pagada con éxito'.
					estado center: self center.
					estado top: buttonPagar bottom + 20 ]
				ifFalse: [ 
					estado contents: 'El usuario ya posee una cuota al día'.
					estado center: self center.
					estado top: buttonPagar bottom + 20 ] ] ].
	buttonPagar actionSelector: #value
]

{ #category : #accessing }
PagarUsuarioPlus >> show [
super show.
estado ifNotNil:[estado contents:''].
]
