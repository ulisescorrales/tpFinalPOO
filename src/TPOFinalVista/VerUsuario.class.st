Class {
	#name : #VerUsuario,
	#superclass : #Morph,
	#instVars : [
		'sistema',
		'retroceder',
		'titulo',
		'menu',
		'colUsuarios',
		'morphPrestamo',
		'menuPrestamos',
		'morphLibros',
		'morphInfo'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
VerUsuario class >> crearConSistema:unSistema [

|unMorph|
unMorph:=self new.
unMorph inicializarConSistema:unSistema.
^unMorph.
]

{ #category : #'as yet unclassified' }
VerUsuario >> botonRetroceder [ 

retroceder:=SimpleButtonMorph new.
	retroceder label:'Volver al menú'font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
	self addMorph:retroceder.
	retroceder bottomLeft:self bottomLeft -(-20@20).

	retroceder target:[
		self hide.
		self owner cargarPantallaRolAdministrador .
		].
	retroceder actionSelector:#value.
]

{ #category : #initialization }
VerUsuario >> inicializarConSistema:unSistema [

sistema:=unSistema.
sistema addDependent:self.

self width:1000.
self height:620.

self mostrarInformacionDeUsuario .

self botonRetroceder .
]

{ #category : #'as yet unclassified' }
VerUsuario >> mostrarInformacionDeUsuario [
colUsuarios := sistema getUsuarios.

titulo:='Seleccione un usuario' asStringMorph .
titulo font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .
self addMorph:titulo.
titulo center:self center-(0@100).


menu:=MenuMorph new.
self addMorph:menu.
menu stayUp: true.
menu topLeft:titulo bottomLeft.
colUsuarios do:[:usuario| 
	menu add:(usuario getDNI)asString,'-',(usuario getApellido),' ',(usuario getNombre)
	target:[		
		morphLibros ifNotNil: [ morphLibros delete ].
		self mostrarUsuario:usuario ]
	selector:#value ].
]

{ #category : #'as yet unclassified' }
VerUsuario >> mostrarPrestamo:unPrestamo [

|fechaInicio fechaEntrega colLibros  temp  tituloPrestamo prev fuente|
morphPrestamo ifNotNil:[
	morphPrestamo delete.
	].
morphLibros ifNotNil:[
	morphLibros delete.
	].

morphPrestamo:=Morph new.
self addMorph:morphPrestamo.
fuente:=(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .
tituloPrestamo:='Libros en la biblioteca seleccionada:' asStringMorph .
tituloPrestamo font:fuente.

morphLibros:=Morph new.
morphLibros addMorph:tituloPrestamo.
prev:=tituloPrestamo.
fechaInicio:=((unPrestamo getFechaEntrega) asString asStringMorph).
fechaEntrega:=((unPrestamo getFechaEntrega)asString asStringMorph).
colLibros:=unPrestamo getColLibros.

colLibros do:[:libro|
	temp:=((libro getISBN),' -> ',(libro getNombre),' (',(libro getTipo),')')asStringMorph.
	temp font:fuente.
	morphLibros addMorph:temp.	
	temp topLeft:prev bottomLeft.
	prev:=temp.
	].
self addMorph:morphLibros.
morphLibros topLeft:morphInfo bottomLeft+(0@200).
]

{ #category : #'as yet unclassified' }
VerUsuario >> mostrarUsuario:unUsuario [

| dni nombre apellido contrasenia colBibliotecas colPrestamos tipo 
etiquetaBibliotecas estaSuspendido morphBibliotecas fuente aux prev  prestamo tituloBibliotecas|
fuente:=(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .

morphInfo ifNotNil: [ morphInfo delete ].
morphInfo :=Morph new.
self addMorph:morphInfo.
morphInfo top:titulo top.
morphInfo right:titulo left-200.

tipo:=('Tipo: ',(unUsuario getTipoUsuario))asStringMorph.
morphInfo   addMorph:tipo.
tipo font:fuente.
tipo topLeft:morphInfo topLeft.

dni:=('DNI: ',(unUsuario getDNI)asString)asStringMorph.
morphInfo  addMorph:dni.
dni font:fuente.
dni topLeft:tipo bottomLeft.

apellido:=('Apellido: ',unUsuario getApellido) asStringMorph.
apellido font:fuente.
morphInfo addMorph:apellido.
apellido topLeft:dni bottomLeft.

nombre:=('Nombre: ',unUsuario getNombre) asStringMorph.
nombre font:fuente.
morphInfo addMorph:nombre.
nombre topLeft: apellido bottomLeft.

contrasenia:=('Contraseña: ',(unUsuario getContrasenia)asString)asStringMorph.
contrasenia font:fuente.
morphInfo addMorph:contrasenia.
contrasenia topLeft:nombre bottomLeft.

etiquetaBibliotecas :='Bibliotecas favoritas: 'asStringMorph.
etiquetaBibliotecas font:fuente.
morphInfo addMorph:etiquetaBibliotecas.
etiquetaBibliotecas topLeft: contrasenia bottomLeft.

morphBibliotecas :=Morph new.
morphInfo addMorph:morphBibliotecas.
colBibliotecas:= unUsuario getBibliotecas.
prev:=etiquetaBibliotecas .
colBibliotecas do:[:biblioteca|
	aux:=((biblioteca getId)asString,'-',biblioteca getNombre)asStringMorph.
	morphBibliotecas addMorph:aux.	
	aux topLeft:prev bottomLeft.
	prev:=aux.
	 ].

estaSuspendido:=(('Esta suspendido: '),(unUsuario estaSuspendido ifTrue:['Hasta', (unUsuario getFinSuspension )asString]  ifFalse:['No'] )) asStringMorph.
estaSuspendido font:fuente.
morphInfo addMorph:estaSuspendido.
estaSuspendido topLeft: prev bottomLeft.

colPrestamos:=unUsuario getPrestamos.

tituloBibliotecas :='Posee préstamo activo en: 'asStringMorph.
tituloBibliotecas font:fuente.
morphInfo addMorph:tituloBibliotecas.
tituloBibliotecas topLeft:estaSuspendido bottomLeft.

menuPrestamos:=MenuMorph new.
menuPrestamos stayUp: true.
morphInfo addMorph:menuPrestamos.
colBibliotecas do:[:biblioteca|
	  prestamo :=biblioteca getPrestamosUsuario: unUsuario .
	  prestamo ifNotNil:[
			prestamo getColPrestamo do:[:p|
				menuPrestamos add:(biblioteca getId)asString,'-',(biblioteca getNombre), ' ->',
				(p getTipoPrestamo)
				target:[menuPrestamos selectedItem isSelected:true.
					self mostrarPrestamo:p.
					]
				selector:#value]
				]
		].
	.

menuPrestamos topLeft:tituloBibliotecas bottomLeft.
]

{ #category : #updating }
VerUsuario >> update:unUsuario [

menu add:(unUsuario  getDNI)asString,'-',(unUsuario  getApellido),' ',(unUsuario getNombre)
	target:[		
		morphLibros ifNotNil: [ morphLibros delete ].
		self mostrarUsuario:unUsuario ]
	selector:#value 
]
