Class {
	#name : #PantallaPrincipal,
	#superclass : #Morph,
	#instVars : [
		'sistema',
		'bienvenida',
		'rolAdmin',
		'rolUsuario'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
PantallaPrincipal class >> crearPantallaPrincipalConSistema:unSistema [
|unMorph|
unMorph:=self new.
unMorph inicializarConSistema: unSistema.
^unMorph
]

{ #category : #'as yet unclassified' }
PantallaPrincipal >> cargarInicio [
| seleccionar subMorph |
self color:Color blue.
self width:1000.
self height:620.
"--------------------Bienvenida-------------------------"
bienvenida:='Bienvenido al sistema de bibliotecas' asMorph.
bienvenida font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 40) .
self addMorphCentered:bienvenida.
bienvenida top: self top.
bienvenida color:Color white.
"--------------------Botones----------------------------"

rolAdmin:=SimpleButtonMorph new.
rolAdmin label:'Administrador'  font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .
self addMorphCentered: rolAdmin.
rolUsuario :=SimpleButtonMorph new.
rolUsuario  label:'Usuario'  font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .
self addMorphCentered: rolUsuario.

rolAdmin position: rolAdmin position +(0@(-150)).
rolUsuario width: rolAdmin width .
rolUsuario topLeft: rolAdmin bottomLeft +(0@20).

seleccionar := 'Seleccione un rol:' asStringMorph .
seleccionar  font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .
self addMorph:seleccionar.
seleccionar bottomLeft: rolAdmin topLeft -(0@20).

rolUsuario target:[
	self hide.
	self owner cargarPantallaRolUsuario.	
	].
rolUsuario actionSelector:#value.

rolAdmin target:[
	self hide.
	self owner cargarPantallaRolAdministrador.	
	].
rolAdmin actionSelector:#value.

]

{ #category : #initialization }
PantallaPrincipal >> inicializarConSistema: unSistema [
sistema:=unSistema.
self cargarInicio.
]

{ #category : #initialization }
PantallaPrincipal >> setSistema:unSistema [
sistema:=unSistema.
]
