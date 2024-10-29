Class {
	#name : #VerUsuariosAtrasados,
	#superclass : #Morph,
	#instVars : [
		'sistema',
		'retroceder',
		'estado'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
VerUsuariosAtrasados class >> crearConSistema: unSistema [

|unMorph|
unMorph :=self new.
unMorph inicializarConSistema: unSistema .
^unMorph .
]

{ #category : #'as yet unclassified' }
VerUsuariosAtrasados >> botonRetroceder [ 
retroceder  :=SimpleButtonMorph new.
self addMorph:retroceder .
retroceder label:'Volver al menú'font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
retroceder bottomLeft:self bottomLeft -(-20@20).
retroceder target:[
	self hide.
	self owner cargarPantallaRolAdministrador .
	].
retroceder actionSelector: #value.
]

{ #category : #initialization }
VerUsuariosAtrasados >> inicializarConSistema: unSistema [

|listaAtrasados morphUsuarios morphBibliotecas usuario  biblioteca |
sistema:=unSistema.
self width:1000.
self height:620.

morphUsuarios :=Morph new.
self addMorph:morphUsuarios.
morphBibliotecas :=Morph new.
self addMorph:morphBibliotecas.
listaAtrasados := sistema generarListadoDeUsuariosAtrasados.

listaAtrasados do:[:tupla| 
	usuario := (((tupla at:1) getDNI)asString,'-',(tupla at:1)getApellido,' ',(tupla at:1)getNombre) asStringMorph.
	morphUsuarios addMorph:usuario.
	
	biblioteca:= (((tupla at:2)getId)asString,'-',(tupla at:2) getNombre)asStringMorph .
	morphBibliotecas addMorph:biblioteca.
	].

morphUsuarios center:self center.
morphBibliotecas topLeft:morphUsuarios topRight.

self botonRetroceder .

(listaAtrasados isEmpty )ifTrue:[
	estado:='No existe ningún usuario con préstamos atrasados' asStringMorph .
	self addMorph:estado.
	estado font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
	estado center:self center.
	]
]
