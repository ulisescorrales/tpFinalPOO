Class {
	#name : #PedirPrestamo,
	#superclass : #BorderedMorph,
	#instVars : [
		'sistema',
		'usuario',
		'retroceder',
		'estado',
		'menuBibliotecas'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
PedirPrestamo class >> crearConSistema: unSistema conUsuario:unUsuario [
|unMorph|
unMorph:=self new.
unMorph inicializarConSistema: unSistema conUsuario:unUsuario.
^unMorph.
]

{ #category : #'as yet unclassified' }
PedirPrestamo >> botonRetroceder [ 
retroceder:=SimpleButtonMorph new.
retroceder label:'Salir'font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
self addMorph:retroceder.
retroceder bottomLeft:self bottomLeft -(-20@20).

retroceder target:[
	self hide.
	self owner cargarOpcionesUsuario.
	].
retroceder actionSelector:#value.

]

{ #category : #'as yet unclassified' }
PedirPrestamo >> elegirLibros:unaBiblioteca [

|menuLibrosD menuLibrosI libros buttonAgregar buttonQuitar crearPrestamo colLibros exito contLibros tipoUsuario|
colLibros:=OrderedCollection new.
self submorphs do:[:m|m delete].
estado:='' asStringMorph .
self addMorph:estado.

contLibros :=0.
menuLibrosD:=MenuMorph new.
menuLibrosD stayUp: true.
self addMorph:menuLibrosD.
menuLibrosI:=MenuMorph new.
menuLibrosI stayUp: true.
self addMorph:menuLibrosI.

libros:= unaBiblioteca getLibrosSinPrestar.

libros do:[:libro|
	menuLibrosI add:(libro getISBN),' -> ',(libro getNombre),' (',(libro getTipo),')'
	target:[(menuLibrosI  selectedItem) isSelected:true]
	selector:#value.
	].

buttonAgregar:=SimpleButtonMorph new.
buttonAgregar label:'Agregar ->' font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
self addMorph:buttonAgregar.

buttonQuitar :=SimpleButtonMorph new.
buttonQuitar label:'<-Quitar' font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
self addMorph:buttonQuitar.

menuLibrosD center:self center +(150@0).
menuLibrosI center:self center -(300@0).
buttonAgregar center:self center - (0@30).
buttonQuitar center:self center + (0@30).

buttonAgregar target:[
	menuLibrosI selectedItem ifNotNil: [ 
		(contLibros <5)ifTrue:[
			contLibros :=contLibros+1.
			menuLibrosD
				add: menuLibrosI selectedItem contents
				target: [ menuLibrosD selectedItem isSelected: true.]
				selector: #value.
			colLibros add:(libros detect:[:libro|(libro getISBN)=
				((((menuLibrosI selectedItem )contents) asString )substrings at:1)
				]).
			menuLibrosI selectedItem delete.
			menuLibrosI selectItem:nil  event: [ ]
			 ]
		ifFalse:[
			estado contents:'Elegir 5 libros como máximo'.
			estado center:self center.
			estado top: crearPrestamo bottom +20.
			] 
		]
	].
buttonAgregar actionSelector: #value.

buttonQuitar target:[
	 menuLibrosD selectedItem ifNotNil:[ 
			menuLibrosI
				add: menuLibrosD selectedItem contents
				target: [ menuLibrosI selectedItem isSelected: true ]
				selector: #value.
			colLibros remove:(colLibros detect:[
				:libro|(libro getISBN)=((((menuLibrosD selectedItem) contents) substrings) at:1)
				]).
			menuLibrosD selectedItem delete.
			menuLibrosD selectItem:nil  event: [ ].
			contLibros:=contLibros-1.
			estado contents:''.
			 ] 
	].
buttonQuitar actionSelector: #value.

crearPrestamo :=SimpleButtonMorph new.
crearPrestamo label:'Crear Préstamo' font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
self addMorph:crearPrestamo.
crearPrestamo center:self center.
crearPrestamo top:buttonQuitar bottom +30.
crearPrestamo target:[
	menuLibrosD submorphs ifNotEmpty: [ 
		exito:=unaBiblioteca  registrarPrestamoConUsuario:usuario conLibros:colLibros.
		exito ifTrue:[
			estado contents:'Préstamo creado correctamente, presione salir'.
			estado center:self center.
			estado top: crearPrestamo bottom +20.
			]ifFalse:[
			estado contents:'Error, no se pudo crear un préstamo'.
			estado center:self center.
			estado top: crearPrestamo bottom +20.
			].		
		 ] 
	ifEmpty: [
		estado contents:'Seleccione por lo menos un libro'.
		estado center:self center.
		estado top: crearPrestamo bottom +20.
		].
	
	].
crearPrestamo actionSelector:#value.

menuLibrosI left:self left+50.
menuLibrosI top:buttonAgregar top.
menuLibrosD top:buttonAgregar top.

tipoUsuario:=(usuario getApellido,' ',usuario getNombre,' (',usuario getTipoUsuario,')') asStringMorph.

self addMorph:tipoUsuario.
tipoUsuario font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
tipoUsuario center:self center.
tipoUsuario top:self top+20.
self botonRetroceder .
]

{ #category : #'as yet unclassified' }
PedirPrestamo >> inicializarConSistema:unSistema conUsuario:unUsuario [

sistema:=unSistema.
usuario:=unUsuario.

self width:1000.
self height:620.

self mostrarPedirPrestamo.

self botonRetroceder.

unUsuario addDependent: self.
]

{ #category : #initialization }
PedirPrestamo >> mostrarPedirPrestamo [
|bibliotecas titulo tipoUsuario|

self submorphs do:[:submorph|submorph delete].
bibliotecas:=usuario getBibliotecasSinPrestamo .

menuBibliotecas :=MenuMorph new.
self addMorph:menuBibliotecas.
bibliotecas do:[:biblioteca|
	menuBibliotecas add:(biblioteca getId)asString,'-',(biblioteca getNombre)
	target:[ 
		self elegirLibros:biblioteca.
		 ]
	selector:#value.	
		].
	
titulo:='Elegir una biblioteca:' asStringMorph.
titulo font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
self addMorph:titulo.

titulo center:self center -(0@30).
menuBibliotecas topLeft:titulo bottomLeft +(0@20).

tipoUsuario:=(usuario getApellido,' ',usuario getNombre,' (',usuario getTipoUsuario,')') asStringMorph.

self addMorph:tipoUsuario.
tipoUsuario font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
tipoUsuario center:self center.
tipoUsuario top:self top+20.

bibliotecas ifEmpty:[
	estado:='No existen bibliotecas disponibles, agregue una biblioteca o devuelva un préstamo' asStringMorph.
	self addMorph:estado.
	estado center:self center.
	estado top:menuBibliotecas top.
	menuBibliotecas delete.
	]

]

{ #category : #accessing }
PedirPrestamo >> show [ 
super show.
self mostrarPedirPrestamo .
]

{ #category : #updating }
PedirPrestamo >> update: unUsuario [

	| bibliotecasUsuario |
	bibliotecasUsuario  := unUsuario getBibliotecas.
	menuBibliotecas submorphs do:[:item|item delete].
	bibliotecasUsuario do:[:biblioteca|
	menuBibliotecas
		add:
		biblioteca getId asString , '-' , biblioteca getNombre
		target: [ self elegirLibros: biblioteca ]
		selector: #value]
]
