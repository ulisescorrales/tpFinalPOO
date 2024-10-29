Class {
	#name : #CambiarMaterial,
	#superclass : #Morph,
	#instVars : [
		'sistema',
		'titulo',
		'listaLibros',
		'menuLibros',
		'agregarLibro',
		'quitarLibro',
		'retroceder'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
CambiarMaterial class >> crearConSistema:unSistema [
|unMorph|
unMorph:=self new.
unMorph inicializarConSistema:unSistema.
^unMorph
]

{ #category : #applying }
CambiarMaterial >> agregarLibro: colCampos colAutores: morphAutores biblioteca: unaBiblioteca [

	| isbn nombre editorial anioEdicion tipo colAutores exito |
	isbn := (colCampos at: 1) getCampo.
	nombre := (colCampos at: 2) getCampo.
	editorial := (colCampos at: 3) getCampo.
	anioEdicion := (colCampos at: 4) getCampo.
	tipo := (colCampos at: 5) getCampo.

	colAutores := morphAutores submorphs collect: [ :a | 
		              Autor
			              crearAutorConApellido:
			              ((a contents asString substrings: ', ') at: 1)
			              conNombre:
			              ((a contents asString substrings: ', ') at: 2) ].

	exito := sistema
		         crearLibroConNombre: nombre
		         tipo: tipo
		         editorial: editorial
		         anioEdicion: anioEdicion
		         colAutor: colAutores
		         isbn: isbn
		         enBiblioteca: unaBiblioteca.	
	^ exito
]

{ #category : #'as yet unclassified' }
CambiarMaterial >> botonRetroceder [ 
retroceder := SimpleButtonMorph new.
	retroceder
		label: 'Volver al menú'
		font: (StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
	self addMorph: retroceder.
	retroceder bottomLeft: self bottomLeft - (-20 @ 20).

	retroceder target: [self hide. self owner cargarPantallaRolAdministrador  ].
	retroceder actionSelector: #value
]

{ #category : #initialization }
CambiarMaterial >> inicializarConSistema: unSistema [

	sistema := unSistema.
	self width: 1000.
	self height: 620.
	self seleccionarBiblioteca.

	self botonRetroceder .
]

{ #category : #applying }
CambiarMaterial >> mostrarAgregarLibroForm:biblioteca [

|isbn nombre nuevoNombre nuevoApellido  anioEdicion editorial tipo morphAutores  agregarAutor quitarAutor  estado colCampos morphPanelAux|

colCampos:=OrderedCollection new.
morphPanelAux:=Morph new.

isbn:= EtiquetaCampo crearConEtiqueta: 'ISBN'.
morphPanelAux addMorph:isbn.
isbn topRight:morphPanelAux topRight.

nombre:=EtiquetaCampo crearConEtiqueta: 'Nombre'.
morphPanelAux addMorph:nombre.
nombre topRight:isbn bottomRight.

editorial:=EtiquetaCampo crearConEtiqueta: 'Editorial'.
morphPanelAux addMorph:editorial.
editorial topRight:nombre bottomRight.

anioEdicion :=EtiquetaCampo crearConEtiqueta: 'Año de edición'.
morphPanelAux addMorph:anioEdicion.
anioEdicion topRight: editorial bottomRight.

tipo:=EtiquetaCampo crearConEtiqueta: 'Tipo'.
morphPanelAux addMorph:tipo.
tipo ponerMenuSeleccionable .
tipo agregarAMenu: 'Impreso'.
tipo agregarAMenu: 'Electrónico'.
tipo agregarAMenu: 'Audio Libro'.
tipo height:60.
tipo topRight:anioEdicion bottomRight.

(tipo getItemCampo ) selectItem:((tipo getItemCampo )submorphs at:1)  event:[].

morphAutores := EtiquetaCampo crearConEtiqueta: 'Autores'.
morphPanelAux addMorph:morphAutores.
morphAutores ponerMenuSeleccionable .
(morphAutores getItemCampo ) width:150;height:100.
morphAutores width:150;height:100.
nuevoApellido:=(EtiquetaCampo crearConEtiqueta: 'Apellido').
nuevoNombre :=(EtiquetaCampo crearConEtiqueta: 'Nombre').
morphPanelAux addMorph: nuevoNombre.
morphPanelAux addMorph: nuevoApellido.

morphAutores topLeft:tipo bottomLeft +(0@20).
nuevoNombre topLeft:morphAutores bottomLeft +(0@20).
nuevoNombre right:anioEdicion right.
nuevoApellido topLeft: nuevoNombre topRight.

agregarAutor:= SimpleButtonMorph new.
agregarAutor label:'Agregar Autor' font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .
agregarAutor target:[morphAutores agregarAMenu:(nuevoApellido getCampo),', ',(nuevoNombre getCampo)].
agregarAutor actionSelector:#value.
morphPanelAux addMorph:agregarAutor.

quitarAutor:= SimpleButtonMorph new.
quitarAutor label:'Quitar Autor'font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .
quitarAutor target:[(morphAutores getSeleccion) 
	ifNotNil:[
		((morphAutores getItemCampo) selectedItem) delete]].
quitarAutor actionSelector:#value.
morphPanelAux  addMorph:quitarAutor.

agregarAutor topLeft: nuevoNombre bottomLeft.
agregarAutor right:anioEdicion right.

colCampos add:isbn;add:nombre;add:editorial;add:anioEdicion;add:tipo.
agregarLibro:= SimpleButtonMorph new.
agregarLibro label:'Agregar Libro'font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .
agregarLibro color:Color red.
agregarLibro target:[
	(self agregarLibro: colCampos colAutores:morphAutores getItemCampo biblioteca:biblioteca) 
	ifTrue:[
		estado contents:'Libro agregado correctamente']
	].
agregarLibro actionSelector:#value.
morphPanelAux addMorph:agregarLibro.
agregarLibro topRight:agregarAutor bottomRight +(0@30).

estado:=''asStringMorph.
morphPanelAux addMorph:estado.

morphPanelAux addMorph:agregarAutor.


quitarAutor position:morphAutores rightCenter.
quitarAutor left:(morphAutores getItemCampo)right.

self addMorph:morphPanelAux.
morphPanelAux top:titulo top.
morphPanelAux right:self right -300.
]

{ #category : #applying }
CambiarMaterial >> mostrarInformacionDeLibro [
]

{ #category : #applying }
CambiarMaterial >> mostrarLibrosDeBiblioteca: unaBiblioteca [

self submorphs do:[:m|m delete].
titulo:=('Libros en ',unaBiblioteca getNombre, ' :') asStringMorph .
titulo font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
self addMorph:titulo.
titulo center:self center -(0@250).
titulo left:self left +200.

listaLibros:=unaBiblioteca getLibros.
Transcript show:listaLibros;cr.
"Menu con libros de la biblioteca"
menuLibros :=MenuMorph new.
self addMorph:menuLibros.
menuLibros width:300.
menuLibros topLeft:titulo bottomLeft.
listaLibros do:[:libro|
	menuLibros add:(libro getISBN),' -> ',(libro getNombre),' (', libro getTipo,')' 	
	target: [(menuLibros selectedItem) isSelected:true.
	self mostrarInformacionDeLibro ]  
	selector:#value ].
menuLibros stayUp: true.

agregarLibro :=SimpleButtonMorph new.
agregarLibro label:'Nuevo Libro' font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .
agregarLibro target:[self mostrarAgregarLibroForm:unaBiblioteca].
agregarLibro actionSelector: #value.
self addMorph:agregarLibro.
agregarLibro topLeft:menuLibros bottomLeft.
agregarLibro bottom:self bottom -100.

quitarLibro :=SimpleButtonMorph new.
quitarLibro label:'Quitar Libro' font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .
quitarLibro target:[menuLibros selectedItem ifNotNil: [
		self quitarLibro:(menuLibros selectedItem) deBiblioteca:unaBiblioteca.
		(menuLibros selectedItem) delete.	
		]
	].
quitarLibro actionSelector:#value.
self addMorph:quitarLibro.
quitarLibro topLeft: (agregarLibro topRight) +(10@0).

retroceder := SimpleButtonMorph new.
	retroceder
		label: 'Seleccionar otra biblioteca'
		font: (StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
	self addMorph: retroceder.
	retroceder bottomLeft: self bottomLeft - (-20 @ 20).

	retroceder target: [ 
		self submorphs do:[:m|m delete].
		self inicializarConSistema:sistema.
		unaBiblioteca removeDependent: self.
		 ].
	retroceder actionSelector: #value
]

{ #category : #applying }
CambiarMaterial >> quitarAutor:unAutor [
|nombre apellido|
nombre:=(unAutor substrings:', ' )at:2.
apellido:=(unAutor substrings:', ' )at:1.


]

{ #category : #applying }
CambiarMaterial >> quitarLibro:unItemSeleccionable deBiblioteca:unaBiblioteca [

|isbn|
isbn:= (((unItemSeleccionable  contents)asString)substrings)at:1.
Transcript show:isbn;cr.
Transcript show:unaBiblioteca;cr.
unaBiblioteca quitarLibro:isbn.
]

{ #category : #applying }
CambiarMaterial >> quitarUnLibro:unItem [

|isbn biblioteca|
sistema quitarUnLibro:isbn deBiblioteca:biblioteca.
]

{ #category : #applying }
CambiarMaterial >> seleccionarBiblioteca [

| morphMenu bibliotecas|

titulo:='Seleccione una biblioteca:'asStringMorph .
titulo font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
self addMorph:titulo.
titulo center:self center-(0@100).

morphMenu:=MenuMorph new.
self addMorph:morphMenu.
morphMenu topLeft:titulo bottomLeft.
self addMorph:morphMenu.
morphMenu topLeft: titulo bottomLeft .
bibliotecas:=(sistema getBibliotecas).
bibliotecas do:[:biblioteca|morphMenu
	add:(biblioteca getId)asString,'-',(biblioteca getNombre)
	target:[
	self mostrarLibrosDeBiblioteca:  biblioteca.
	biblioteca addDependent:self.
		] selector:#value].

]

{ #category : #updating }
CambiarMaterial >> update:unLibro [
menuLibros add:(unLibro getISBN),' -> ',(unLibro getNombre),' (', unLibro getTipo,')' 	
	target: [(menuLibros selectedItem) isSelected:true.
	self mostrarInformacionDeLibro ]  
	selector:#value.
]
