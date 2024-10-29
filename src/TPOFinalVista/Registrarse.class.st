Class {
	#name : #Registrarse,
	#superclass : #BorderedMorph,
	#instVars : [
		'sistema',
		'campos',
		'estado',
		'nombre',
		'buttonCrear',
		'dni',
		'apellido',
		'contrasenia',
		'tipoUsuario',
		'colBibliotecas',
		'retroceder'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
Registrarse class >> crearConSistema:unSistema [

|unMorph|
unMorph:=self new.
unMorph inicializarConSistema:unSistema.
^unMorph
]

{ #category : #'as yet unclassified' }
Registrarse >> botonRetroceder [
retroceder:=SimpleButtonMorph new.
retroceder label:'Volver a inicio de sesión'font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
self addMorph:retroceder.
retroceder bottomLeft:self bottomLeft -(-20@20).

retroceder target:[
	self hide.
	self owner cargarPantallaRolUsuario .
	].
retroceder actionSelector:#value.
]

{ #category : #accessing }
Registrarse >> crearUsuario [

	| exito elTipoDeUsuario unDni unNombre unApellido unaContrasenia |
	elTipoDeUsuario := tipoUsuario getItemCampo selectedItem
		                   valueFromContents.
	exito := true.
	self verificarCampos ifTrue: [ "Cargar valores ingresados"
		unDni := dni getCampo.
		unNombre := nombre getCampo.
		unApellido := apellido getCampo.
		unaContrasenia := contrasenia getCampo.
		"Crear el usuario según el tipo elegido"
		elTipoDeUsuario = 'Usuario normal'
			ifTrue: [ 
				(sistema
					 crearUsuarioConDNI: unDni asInteger
					 nombre: unNombre
					 apellido: unApellido
					 contrasenia: unaContrasenia) ifFalse: [ 
					exito := false.
					estado contents: 'DNI ya existe' ] ]
			ifFalse: [ 
				elTipoDeUsuario = 'Usuario plus' ifTrue: [ 
					(sistema
						 crearUsuarioPlusConDNI: unDni asInteger
						 nombre: unNombre
						 apellido: unApellido
						 contrasenia: unaContrasenia) ifFalse: [ 
						exito := false.
						estado contents: 'DNI ya existe' ] ] ] ]
		ifFalse:[exito:=false].
	^ exito
]

{ #category : #initialization }
Registrarse >> inicializarConSistema:unSistema [
sistema:=unSistema.
self width:1000.
self height: 620.

self mostrarFormularioCrearUsuario.

self botonRetroceder.
]

{ #category : #'as yet unclassified' }
Registrarse >> mostrarFormularioCrearUsuario [

	campos := Morph new.

	dni := EtiquetaCampo crearConEtiqueta: 'DNI'.
	campos addMorph: dni.

	nombre := EtiquetaCampo crearConEtiqueta: 'Nombre'.
	campos addMorph: nombre.
	nombre top: dni bottom.


	apellido := EtiquetaCampo crearConEtiqueta: 'Apellido'.
	campos addMorph: apellido.
	apellido top: nombre bottom.

	contrasenia := EtiquetaCampo crearConEtiqueta: 'Contraseña'.
	campos addMorph: contrasenia.
	contrasenia top: apellido bottom.

	tipoUsuario := EtiquetaCampo crearConEtiqueta: 'Tipo de Usuario'.
	self addMorph: tipoUsuario.
	tipoUsuario ponerMenuSeleccionable.
	tipoUsuario agregarAMenu: 'Usuario normal'.
	tipoUsuario agregarAMenu: 'Usuario plus'.
	"Inicializar con Usuario normal seleccionado"
	tipoUsuario getItemCampo
		selectItem: (tipoUsuario getItemCampo submorphs at: 1)
		event: [  ].

	tipoUsuario topLeft: contrasenia bottomLeft.
	tipoUsuario height: tipoUsuario getItemCampo height.
	
	buttonCrear := SimpleButtonMorph new.
	buttonCrear
		label: 'Crear Usuario'
		font: (StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
	self addMorph: buttonCrear.
	buttonCrear center:self center.

	buttonCrear target: [ 
		dni getCampo = ''
			ifFalse: [ 
				(self	crearUsuario )
					ifTrue: [ 
						estado contents:'Usuario creado correctamente'.
						]
					 ]
			ifTrue: [ estado contents: 'Colocar un DNI' ] ].
	buttonCrear actionSelector: #value.

	estado := '' asStringMorph.
	self addMorph: campos.
	campos width: tipoUsuario width.
	campos submorphs do: [ :m | m right: campos right ].

	campos top: self top + 100.
	campos right: buttonCrear right.
	tipoUsuario topRight: contrasenia bottomRight.
	self addMorph: estado.
	
buttonCrear position:buttonCrear position +(0@20).
	estado topLeft: buttonCrear bottomLeft.
]

{ #category : #'as yet unclassified' }
Registrarse >> verificarCampos [

	| correcto |
	campos submorphs
		detect: [ :m | m getCampo = '' ]
		ifFound: [ correcto := false .
			estado contents:'Falta rellenar campos'.
			]
		ifNone: [ 
			(dni getCampo) isAllDigits
				ifTrue: [ correcto := true ]
				ifFalse: [ 
					correcto := false.
					estado contents: 'DNI debe ser un número' ] ].
	^ correcto
]
