Class {
	#name : #EtiquetaCampo,
	#superclass : #Morph,
	#instVars : [
		'etiqueta',
		'campo',
		'usaMenu'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
EtiquetaCampo class >> crearConEtiqueta:etiqueta [
|unMorph|
unMorph:=self new.

unMorph inicializarConEtiqueta:etiqueta.
^unMorph.
]

{ #category : #applying }
EtiquetaCampo >> agregarAMenu: unString [ 
"Mantener la selección en el menú"
|h|
h:=0.
(self usaMenu) ifTrue:[ campo add:unString  target:[(campo selectedItem) isSelected:true]  selector: #value].
]

{ #category : #applying }
EtiquetaCampo >> cambiarFuente:fuente [

etiqueta font:fuente.
campo left:etiqueta right.
]

{ #category : #'set and get' }
EtiquetaCampo >> getCampo [
|retornar|
usaMenu ifFalse:[
	retornar:=(campo contents) asString] 
	ifTrue:[
		retornar:= (campo selectedItem) contents].
^retornar
]

{ #category : #'set and get' }
EtiquetaCampo >> getItemCampo [
^campo
]

{ #category : #'set and get' }
EtiquetaCampo >> getItemEtiqueta [
^etiqueta.
]

{ #category : #'set and get' }
EtiquetaCampo >> getSeleccion [
|retornar|
usaMenu ifTrue:[(campo selectedItem) ifNotNil:[retornar:= ((campo selectedItem) contents) asString]].
^retornar
]

{ #category : #initialize }
EtiquetaCampo >> inicializarConEtiqueta:unaEtiqueta [

usaMenu:=false.
etiqueta:= (unaEtiqueta,':') asStringMorph .
campo:=InputText new.
campo width:100.
campo backgroundColor:Color gray .
campo color:Color black.

self width:(etiqueta width)+(campo width).
self addMorph:campo.
self addMorph:etiqueta.

campo position: (etiqueta position)+((etiqueta width)@0).
]

{ #category : #applying }
EtiquetaCampo >> ponerMenuSeleccionable [
campo delete.
campo:=MenuMorph new.
campo stayUp: true.
campo topLeft: etiqueta topRight.
self addMorph:campo.
usaMenu:=true.
]

{ #category : #accessing }
EtiquetaCampo >> usaMenu [
^usaMenu .
]

{ #category : #applying }
EtiquetaCampo >> vaciarCampo [

campo contentsWrapped:''.
]
