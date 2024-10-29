Class {
	#name : #CambiarModalidadUsuario,
	#superclass : #Morph,
	#instVars : [
		'sistema',
		'retroceder',
		'estado',
		'titulo',
		'morphMenu',
		'usuarios'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
CambiarModalidadUsuario class >> crearConSistema:unSistema [

|unMorph|
unMorph:=self new.
unMorph inicializarConSistema:unSistema.
^unMorph.
]

{ #category : #'as yet unclassified' }
CambiarModalidadUsuario >> botonRetroceder [ 
retroceder:=SimpleButtonMorph new.
retroceder label:'Retroceder'font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
self addMorph:retroceder.
retroceder bottomLeft:self bottomLeft -(-20@20).

retroceder target:[
	self hide.
	self owner cargarPantallaRolAdministrador .
	].
retroceder actionSelector:#value.
]

{ #category : #accessing }
CambiarModalidadUsuario >> cambiarModalidadUsuario: unUsuario [

	 sistema cambiarModalidadUsuario: (unUsuario).	

]

{ #category : #initialize }
CambiarModalidadUsuario >> inicializarConSistema:unSistema [

sistema:=unSistema.
self width:1000;height:620.
self mostrarFormCambiarModalidadUsuario.

self botonRetroceder.
]

{ #category : #applying }
CambiarModalidadUsuario >> mostrarFormCambiarModalidadUsuario [
titulo:='Seleccione un usuario:'asStringMorph .
self addMorph:titulo.
titulo center:self center -(0@30).

morphMenu:=MenuMorph new.
morphMenu width:150.
morphMenu stayUp:true.
self addMorph:morphMenu.
morphMenu center:self center.
morphMenu top: titulo bottom .
usuarios:= sistema getUsuarios .
usuarios do:[:usuario|morphMenu 
	add:(usuario getDNI)asString ,'-',(usuario getApellido),' ',(usuario getNombre) ,' (',(usuario getTipoUsuario ),')'
	target:[
		usuario addDependent:self.
		self cambiarModalidadUsuario: usuario.
		usuario removeDependent: self.
		morphMenu selectedItem delete.
		] 
	selector:#value].

estado:='' asStringMorph .
self addMorph:estado.
estado topLeft:morphMenu bottomLeft +(0@20).
titulo position:titulo position -(0@20).
titulo font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
]

{ #category : #accessing }
CambiarModalidadUsuario >> show [
super show.
estado ifNotNil:[estado contents:''].
]

{ #category : #updating }
CambiarModalidadUsuario >> update:unUsuario [

morphMenu 
	add:(unUsuario getDNI)asString ,'-',(unUsuario getApellido),' ',(unUsuario getNombre) ,' (',(unUsuario getTipoUsuario ),')'
	target:[
		unUsuario addDependent:self.
		self cambiarModalidadUsuario: unUsuario.
		unUsuario removeDependent: self.
		morphMenu selectedItem delete.
		] 
	selector:#value.

	estado contents:'Usuario ',(unUsuario getDNI)asString,' cambiado correctamente a ',(unUsuario getTipoUsuario ).
	estado center:self center.
	estado top:morphMenu bottom +20.
]
