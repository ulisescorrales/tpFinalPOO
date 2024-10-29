Class {
	#name : #RolUsuario,
	#superclass : #BorderedMorph,
	#instVars : [
		'sistema',
		'iniciarSesion',
		'cerrarSesion',
		'agregarBiblioteca',
		'pedirPrestamo',
		'registrarse',
		'estaRegistrado',
		'usuario',
		'contrasenia',
		'estado',
		'retroceder',
		'elUsuario'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
RolUsuario class >> crearConSistema:unSistema [

|unMorph|
unMorph:= self new.

unMorph inicializarConSistema:unSistema.
^unMorph
]

{ #category : #'as yet unclassified' }
RolUsuario >> DNIValido [
^ (usuario getCampo) isAllDigits 
]

{ #category : #'as yet unclassified' }
RolUsuario >> inicializarBotones [

	iniciarSesion target: [ 
		self verificarCamposInicioSesion
			ifTrue: [ 
				self DNIValido
					ifTrue: [ 
						elUsuario := sistema getUsuario: usuario getCampo asInteger.
						elUsuario
							ifNotNil: [ 
								(elUsuario validarContrasenia: (contrasenia getCampo))								
									ifTrue: [ 
										self hide.
										self owner cargarOpcionesUsuarioConUsuario:elUsuario.]
									ifFalse: [ estado contents: 'Contraseña Incorrecta'.
										 ] ]
							ifNil: [ estado contents: 'Usuario no registrado' ] ]
					ifFalse: [ estado contents: 'DNI debe ser un número' ] ]
			ifFalse: [ estado contents: 'Falta llenar un campo' ] ].
	iniciarSesion actionSelector: #value.

	registrarse target: [ 
		self hide.
		self owner cargarPantallaRegistrarse.		
		].
		
	registrarse actionSelector: #value.
	retroceder:=SimpleButtonMorph new.
	retroceder label:'Volver al menú principal'font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
	self addMorph:retroceder.
	retroceder bottomLeft:self bottomLeft -(-20@20).

	retroceder target:[
		self hide.
		self owner cargarPantallaPrincipal .
		].
	retroceder actionSelector:#value.
]

{ #category : #'as yet unclassified' }
RolUsuario >> inicializarConSistema:unSistema [

sistema:=unSistema.
self width:1000.
self height: 620.

estaRegistrado :=false.

iniciarSesion :=SimpleButtonMorph new.
iniciarSesion label: 'Iniciar Sesión' font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
registrarse :=SimpleButtonMorph new.
registrarse label: 'Registrarse' font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
self addMorph: iniciarSesion.
self addMorph:registrarse.

cerrarSesion:=SimpleButtonMorph new.

iniciarSesion center: self center.
registrarse  topLeft: iniciarSesion bottomLeft +(0@10).
registrarse width:iniciarSesion width.

usuario:= EtiquetaCampo crearConEtiqueta: 'DNI'.
contrasenia:= EtiquetaCampo  crearConEtiqueta: 'Contraseña'.
self addMorph:usuario.
self addMorph: contrasenia.

usuario center:self center.
usuario position: usuario position + (0@(-150)).
usuario right: iniciarSesion right.
contrasenia topRight: usuario bottomRight.


estado:='' asStringMorph .
estado font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 14);color:Color red.
self addMorph:estado.
estado topLeft:contrasenia bottomLeft.
estado left: iniciarSesion left.

self inicializarBotones.
]

{ #category : #'as yet unclassified' }
RolUsuario >> recargar [

self submorphs do:[:m|m delete].
self inicializarConSistema:sistema.
]

{ #category : #accessing }
RolUsuario >> show [ 
super show.
"usuario getItemCampo contents:''.
usuario getItemCampo width:100."
]

{ #category : #'as yet unclassified' }
RolUsuario >> verificarCamposInicioSesion [
^ (usuario getCampo='')not & (contrasenia getCampo='')not.
]
