Class {
	#name : #VerBiblioteca,
	#superclass : #Morph,
	#instVars : [
		'sistema',
		'titulo',
		'retroceder',
		'morphLibros',
		'menuLibros',
		'infoLibro',
		'tipoUsuario',
		'morphMenu',
		'morphPrestamo',
		'biblioteca'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
VerBiblioteca class >> crearConSistema:unSistema conBiblioteca:unaBiblioteca [

|unMorph|
unMorph:=self new.
unMorph inicializarConSistema:unSistema conBiblioteca:unaBiblioteca.
^unMorph .
]

{ #category : #'as yet unclassified' }
VerBiblioteca >> botonRetroceder [

	retroceder := SimpleButtonMorph new.
	retroceder
		label: 'Volver al menú'
		font: (StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
	self addMorph: retroceder.
	retroceder bottomLeft: self bottomLeft - (-20 @ 20).

	retroceder target: [ 
		self hide.
		self owner cargarSeleccionarVerBiblioteca .		
		 ].
	retroceder actionSelector: #value


]

{ #category : #'as yet unclassified' }
VerBiblioteca >> inicializarConSistema:unSistema conBiblioteca:unaBiblioteca [
sistema:=unSistema.
biblioteca:=unaBiblioteca.
self width: 1000.
self height: 620.

self mostrarBiblioteca: biblioteca.
self botonRetroceder .
]

{ #category : #'as yet unclassified' }
VerBiblioteca >> mostrarBiblioteca: biblioteca [
|id nombre telefono representante tiempoDev fuente prestamosActivos menuPrestamos prev aux fechaIn fechaEntrega tituloLibros tituloPrestamos |
fuente:=(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .
morphPrestamo:=Morph new.

id:=('Id: ',(biblioteca getId)asString) asStringMorph.
id font:fuente.
self addMorph:id.
id center:self center -(0@200).
id left:self left+200.

nombre:=('Nombre: ',biblioteca getNombre) asStringMorph.
nombre font:fuente.
self addMorph:nombre.
nombre topLeft: id bottomLeft -((nombre width/2)@0).

representante:=('Representante: ',biblioteca getRepresentante ) asStringMorph.
representante font:fuente.
self addMorph:representante.
representante topLeft:nombre bottomLeft.

telefono:=('Telefono: ',(biblioteca getTelefono)asString) asStringMorph.
telefono font:fuente.
self addMorph:telefono.
telefono topLeft:representante bottomLeft.

tiempoDev:=('Tiempo para devolución (dìas): ',(biblioteca getTiempoDevolucionDias)asString ) asStringMorph.
tiempoDev font:fuente.
self addMorph:tiempoDev.
tiempoDev topLeft:telefono bottomLeft.

tituloPrestamos:='Prestamos activos por usuario:' asStringMorph .
self addMorph:tituloPrestamos.
tituloPrestamos topLeft:tiempoDev bottomLeft.
tituloPrestamos font:fuente.

menuPrestamos:=MenuMorph new.
menuPrestamos stayUp: true.
self addMorph:menuPrestamos.
menuPrestamos topLeft:tituloPrestamos bottomLeft.

tituloLibros:='' asStringMorph .
prestamosActivos :=biblioteca getPrestamosActivos.
prestamosActivos do:[:prestamo|
		menuPrestamos add:(((prestamo getUsuario) getDNI)asString,'-',(prestamo getUsuario)getApellido,' ',(prestamo getUsuario)getNombre)
	target:[
		morphPrestamo ifNotNil:[morphPrestamo delete.
			morphPrestamo:=Morph new.
			].
		menuPrestamos selectedItem isSelected:true.
		fechaIn:=('Fecha de Inicio:',(prestamo getFechaInicio)) asStringMorph.
		fechaEntrega :=('Fecha de entrega:',(prestamo getFechaEntrega )) asStringMorph.
		morphPrestamo addMorph: fechaIn.
		morphPrestamo addMorph: fechaEntrega .		
		fechaEntrega topLeft:fechaIn bottomLeft.
		tituloLibros contents:'Libros en préstamo:'.
		morphPrestamo addMorph: tituloLibros .		
		tituloLibros topLeft:fechaEntrega bottomLeft.
		prev:=tituloLibros.
		prestamo getColLibros do:[:libro|
			aux:=((libro getISBN),' -> ',(libro getNombre),' (',(libro getTipo),')')asStringMorph.
			morphPrestamo addMorph:aux.
			aux topLeft:prev bottomLeft.
			prev:=aux.
			].
		self addMorph:morphPrestamo.
		morphPrestamo topLeft:menuPrestamos topRight.
		]	
		selector:#value.
		]
	.
	
self verLibros:biblioteca.
]

{ #category : #applying }
VerBiblioteca >> mostrarInformacionDeLibro:unLibro [

|isbn nombre autores tipo prestado anioEdicion editorial tituloAutores aux prev|
infoLibro ifNotNil:[infoLibro delete].
infoLibro:=Morph new.
self addMorph:infoLibro.



isbn:=('ISBN: ',(unLibro getISBN ))asStringMorph.
infoLibro addMorph:isbn.


nombre:=('Nombre: ',(unLibro getNombre ))asStringMorph.
infoLibro addMorph:nombre.
nombre topLeft:isbn bottomLeft.


tipo:=('Tipo: ',(unLibro getTipo))asStringMorph.
tipo topLeft:nombre bottomLeft.
infoLibro addMorph:tipo.

anioEdicion :=('Año de edición: ',(unLibro getAnioEdicion )asString) asStringMorph.
anioEdicion topLeft:tipo bottomLeft.
infoLibro addMorph:anioEdicion.

editorial:=('Editorial: ',(unLibro getEditorial)) asStringMorph.
editorial topLeft:anioEdicion bottomLeft.
infoLibro addMorph:editorial.

prestado:=('Esta prestado: ',(unLibro getPrestado )asString)asStringMorph.
prestado topLeft:editorial bottomLeft.
infoLibro addMorph:prestado.

tituloAutores:='Autores: 'asStringMorph .
tituloAutores  topLeft:prestado bottomLeft.
infoLibro addMorph:tituloAutores.

prev:=tituloAutores.
autores := unLibro getAutores.

autores do:[:autor|
	aux:=((autor getApellido),' ',(autor getNombre)) asStringMorph.
	infoLibro addMorph:aux.
	aux topLeft:prev bottomLeft.
	].

infoLibro topLeft: menuLibros  bottomLeft .
]

{ #category : #initialization }
VerBiblioteca >> setBiblioteca:unaBiblioteca [
biblioteca:=unaBiblioteca .
]

{ #category : #initialization }
VerBiblioteca >> setTipoUsuario:unTipoUsuario [
tipoUsuario :=unTipoUsuario .
]

{ #category : #showing }
VerBiblioteca >> show:unaBiblioteca [
super show.
(biblioteca == unaBiblioteca )ifFalse:[
	self submorphs do:[:s|s delete].
	self inicializarConSistema: sistema conBiblioteca: unaBiblioteca 
	]
]

{ #category : #'as yet unclassified' }
VerBiblioteca >> verLibros:unaBiblioteca [

| libros titulo|
morphLibros ifNotNil:[morphLibros delete].
morphLibros :=Morph new.
self addMorph:morphLibros.
menuLibros:=MenuMorph new.
menuLibros stayUp: true.

libros:=unaBiblioteca getLibros.

titulo:=('Libros en ',(unaBiblioteca getNombre),':')asStringMorph.
titulo font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .

morphLibros addMorph:titulo.
morphLibros addMorph:menuLibros.
menuLibros topLeft:titulo bottomLeft.
libros do:[:libro|
	menuLibros add:((libro getISBN ),' -> ',(libro getNombre),' (',(libro getTipo),')')
	target:
			[ menuLibros selectedItem isSelected:true.
			self mostrarInformacionDeLibro:libro.
			 ]
	selector:#value
	].
morphLibros  center:self center -(0@200).
]
