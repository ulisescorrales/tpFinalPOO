Class {
	#name : #SetDiasImporte,
	#superclass : #Morph,
	#instVars : [
		'sistema',
		'retroceder',
		'estado',
		'estado2'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
SetDiasImporte class >> crearConSistema: unSistema [

|unMorph|
unMorph:=self new.
unMorph inicializarConSistema:unSistema.
^unMorph.
]

{ #category : #'as yet unclassified' }
SetDiasImporte >> botonRetroceder [ 
	retroceder := SimpleButtonMorph new.
	retroceder
		label: 'Volver al menú'
		font: (StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
	self addMorph: retroceder.
	retroceder bottomLeft: self bottomLeft - (-20 @ 20).

	retroceder target: [ self hide.
		self owner cargarPantallaRolAdministrador].
	retroceder actionSelector: #value.
]

{ #category : #initialization }
SetDiasImporte >> inicializarConSistema: unSistema [

	| fuente buttonAceptar etiqueta dias importe buttonImporte signo|
	sistema := unSistema.
	self width: 1000.
	self height: 620.

	fuente := fuente := StrikeFont
		                    familyName: 'Bitmap DejaVu Sans'
		                    size: 20.

	buttonAceptar := SimpleButtonMorph new.
	buttonAceptar label: 'Modificar días de suspensión' font: fuente.
	self addMorph: buttonAceptar.
	buttonAceptar center: self center.
	buttonAceptar target: [ 
		etiqueta getCampo = ''
			ifFalse: [ 
				etiqueta getCampo isAllDigits
					ifTrue: [ 
						sistema setDiasSuspension: etiqueta getCampo asInteger.
						estado contents: 'Días cambiados correctamente'.
						estado center: self center.
						estado top: buttonAceptar bottom + 20 ]
					ifFalse: [ 
						estado contents: 'Debe colocar un número'.
						estado center: self center.
						estado top: buttonAceptar bottom + 20 ] ]
			ifTrue: [ estado contents: 'Debe colocar un número' ] ].
	buttonAceptar actionSelector: #value.

	etiqueta := EtiquetaCampo crearConEtiqueta:
		            'Cantidad de días de suspensión'.
	self addMorph: etiqueta.
	etiqueta center: self center.
	etiqueta bottom: buttonAceptar top.
	etiqueta left:buttonAceptar left.

	estado := '' asStringMorph.
	self addMorph: estado.
	estado topLeft: buttonAceptar bottomLeft.

	etiqueta cambiarFuente:
		(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 18).
	
	self botonRetroceder .

	dias := sistema getDiasSuspension.
	etiqueta getItemCampo contents: dias asString.
	
	estado2:=''asStringMorph .
	self addMorph:estado2.	
	importe:=EtiquetaCampo crearConEtiqueta: 'Importe para Usuario Plus'.

	self addMorph:importe.
	importe getItemCampo contents:(Cuota getValorCuota )asString.
	importe cambiarFuente:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 18).
	buttonImporte:=SimpleButtonMorph new.
	self addMorph:buttonImporte.
	buttonImporte label:'Modificar importe' font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).	
	buttonImporte target:[
		((importe getCampo)='') ifFalse:[
		(importe getCampo) isAllDigits ifTrue:[
		Cuota setValorCuota:importe getCampo asInteger.
		estado2 contents:'Importe cambiado correctamente'.
		estado2 center:self center.
		estado2 top:buttonImporte top +30.
		]
	ifFalse:[
		estado2 contents:'Importe debe ser un número'.
		estado2 center:self center.
		estado2 top:buttonImporte top +30.
		].
		]
		ifTrue:[
			estado2 contents:'Coloque un importe'.
		estado2 center:self center.
		estado2 top:buttonImporte top +30.
			]
	]
	
.	
	buttonImporte actionSelector: #value.
	
	importe center:self center.
	importe top:estado top +50.
	
	buttonImporte center:self center.
	buttonImporte top: importe bottom+10.
	
	signo:='$' asStringMorph .
	self addMorph:signo.
	signo topLeft:importe topRight.
]

{ #category : #accessing }
SetDiasImporte >> show [ 
super show.
estado2 ifNotNil: [ estado2 contents:'' ].
]
