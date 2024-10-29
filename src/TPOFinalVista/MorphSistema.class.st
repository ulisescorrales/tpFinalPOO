Class {
	#name : #MorphSistema,
	#superclass : #Morph,
	#instVars : [
		'sistema',
		'rolUsuario',
		'rolAdmin',
		'pantallaPrincipal',
		'agregarBibliotecaAdministrador',
		'pantallaRegistrarse',
		'pantallaPedirPrestamo',
		'pantallaPagarUsuarioPlus',
		'pantallaDevolverPrestamo',
		'pantallaCambiarModalidadUsuario',
		'pantallaCambiarMaterial',
		'pantallaAgregarBibliotecaUsuario',
		'pantalla',
		'pagarUsuarioPlus',
		'pantallaVerUsuario',
		'pantallaVerUsuariosAtrasados',
		'pantallaSetDiasImporte',
		'pantallaVerBiblioteca',
		'pantallaCambiarMatBibliogr',
		'pantallaUsuariosAtrasados',
		'pantallaOpcionesUsuario',
		'pantallaSeleccionarVerBiblioteca',
		'pantallaMostrarBiblioteca'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
MorphSistema class >> crearMorphSistemaConSistema:unSistema [
|unMorphSistema|
unMorphSistema:=self new.
unMorphSistema inicializarSistema:unSistema.
^unMorphSistema .
]

{ #category : #'as yet unclassified' }
MorphSistema class >> crearMorphSistemaConSistemaVacio [
|unMorphSistema|
unMorphSistema:=self new.
unMorphSistema inicializarSistemaVacio.
^unMorphSistema .
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarAgregarBibliotecaUsuario: unUsuario [

	pantallaAgregarBibliotecaUsuario
		ifNotNil: [ pantallaAgregarBibliotecaUsuario show ]
		ifNil: [ 
			Transcript show:'Nueva Ventana creada';cr.
			pantallaAgregarBibliotecaUsuario := AgregarBibliotecaUsuario
				                                    crearConSistema: sistema
				                                    conUsuario: unUsuario.
			self addMorph: pantallaAgregarBibliotecaUsuario.
			pantallaAgregarBibliotecaUsuario topLeft: self topLeft ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarCambiarModalidadUsuario [

	pantallaCambiarModalidadUsuario
		ifNotNil: [ pantallaCambiarModalidadUsuario show ]
		ifNil: [ 
			pantallaCambiarModalidadUsuario := CambiarModalidadUsuario 
				                                   crearConSistema: sistema.
			self addMorph: pantallaCambiarModalidadUsuario.
			pantallaCambiarModalidadUsuario topLeft: self topLeft ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarDevolverPrestamoConUsuario: unUsuario [

	pantallaDevolverPrestamo
		ifNotNil: [ pantallaDevolverPrestamo show ]
		ifNil: [ 
			pantallaDevolverPrestamo := DevolverPrestamo
				                            crearConSistema: sistema
				                            conUsuario: unUsuario.
			self addMorph: pantallaDevolverPrestamo.
			pantallaDevolverPrestamo topLeft: self topLeft ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarEjemploDeSistema [

|unSistema usuario1 usuario2 usuario3 usuario4 colUsuarios biblioteca1 biblioteca2 biblioteca3 colBibliotecas unaColAutor col1|

colUsuarios :=OrderedCollection new.
colBibliotecas :=OrderedCollection new.

usuario1:=Usuario crearUsuarioConDNI:1  nombre:'Carlos'  apellido:'Rodriguez'  contrasenia:'1' .
usuario2:= UsuarioPlus crearUsuarioPlusConDNI: 2 nombre:'Santiago'  apellido:'Gomez'  contrasenia: '2'.
usuario2 pagarCuota .
usuario3:=UsuarioPlus crearUsuarioPlusConDNI: 3 nombre:'Manuel'  apellido:'Garcia'  contrasenia: '3'.

usuario4:=Usuario crearUsuarioConDNI: 4 nombre:'Maria'  apellido:'Martinez'  contrasenia: '4'.
colUsuarios add:usuario1;add:usuario2;add:usuario3;add:usuario4.

biblioteca1 :=Biblioteca crearBibliotecaConid: 1 direccion:'Bs As 400'  nombre:'Biblioteca UNCO'  telefono:2981111  representante:'Carlos Zamora'  tiempoDevolucion: 10.

biblioteca2 :=Biblioteca crearBibliotecaConid: 2 direccion:'Neuquén 3888'  nombre:'Biblioteca de Neuquén'  telefono:298222222  representante:'Marta Sanchez'  tiempoDevolucion: 7.

biblioteca3 :=Biblioteca crearBibliotecaConid: 3 direccion:'Corrientes 1111'  nombre:'Biblioteca Popular'  telefono:29844444  representante:'Samuel Garay'  tiempoDevolucion: 14.

colBibliotecas add:biblioteca1;add:biblioteca2;add:biblioteca3.

unSistema:=SistemaBilioteca crearSistemaConBibliotecas: colBibliotecas  conUsuarios: colUsuarios.

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Saint Exupery'  conNombre:'Antoine' ).

unSistema crearLibroConNombre:'El Principito'  tipo:'Impreso'  editorial:'El ateneo'  anioEdicion:2000  colAutor:unaColAutor  isbn:'1111-222'  enBiblioteca:biblioteca1 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Homero'  conNombre:'').

unSistema crearLibroConNombre:'La odisea'  tipo:'Electrónico'  editorial:'Utopia'  anioEdicion:1994  colAutor:unaColAutor  isbn:'333-2222'  enBiblioteca:biblioteca1 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Cortázar'  conNombre:'Rayuela').

unSistema crearLibroConNombre:'Rayuela'  tipo:'Audio Libro'  editorial:'Paidos'  anioEdicion:1950  colAutor:unaColAutor  isbn:'444-2222'  enBiblioteca:biblioteca1 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Borges'  conNombre:'Jorge').

unSistema crearLibroConNombre:'Ficciones'  tipo:'Impreso'  editorial:'Emecé'  anioEdicion:1960  colAutor:unaColAutor  isbn:'444-8888'  enBiblioteca:biblioteca1 .
"Crear un dos préstamos vencidos para usuario2"
col1:=OrderedCollection new.
col1 add:biblioteca1.
usuario2 setBibliotecas: col1.
col1:=OrderedCollection new.
col1 add:(biblioteca1 getLibros at:1).
col1 add:(biblioteca1 getLibros at:2).

biblioteca1 registrarPrestamoConUsuario: usuario2 conLibros: col1 .
(biblioteca1 getPrestamos at:1)setFechaInicio: (Date newDay: 1 month:1  year:2023 ).

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Zábato'  conNombre:'Ernesto').

unSistema crearLibroConNombre:'El túnel'  tipo:'Audio Libro'  editorial:'Colihue'  anioEdicion:1980  colAutor:unaColAutor  isbn:'444-777772'  enBiblioteca:biblioteca1 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Tahan'  conNombre:'Malba').

unSistema crearLibroConNombre:'El hombre que calculaba'  tipo:'Impreso'  editorial:'Paidos'  anioEdicion:2020  colAutor:unaColAutor  isbn:'111-777772'  enBiblioteca:biblioteca1 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Hernandez'  conNombre:'José').

unSistema crearLibroConNombre:'Martin Fierro'  tipo:'Impreso'  editorial:'EDUBA'  anioEdicion:2000  colAutor:unaColAutor  isbn:'111-7347772'  enBiblioteca:biblioteca1 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Saint Exupery'  conNombre:'Antoine' ).

unSistema crearLibroConNombre:'El Principito'  tipo:'Impreso'  editorial:'El ateneo'  anioEdicion:2000  colAutor:unaColAutor  isbn:'1111-222'  enBiblioteca:biblioteca2 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Homero'  conNombre:'').

unSistema crearLibroConNombre:'La odisea'  tipo:'Electrónico'  editorial:'Utopia'  anioEdicion:1994  colAutor:unaColAutor  isbn:'333-2222'  enBiblioteca:biblioteca2 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Cortázar'  conNombre:'Rayuela').

unSistema crearLibroConNombre:'Rayuela'  tipo:'Audio Libro'  editorial:'Paidos'  anioEdicion:1950  colAutor:unaColAutor  isbn:'444-2222'  enBiblioteca:biblioteca2 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Borges'  conNombre:'Jorge').

unSistema crearLibroConNombre:'Ficciones'  tipo:'Impreso'  editorial:'Emecé'  anioEdicion:1960  colAutor:unaColAutor  isbn:'444-8888'  enBiblioteca:biblioteca2 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Zábato'  conNombre:'Ernesto').

unSistema crearLibroConNombre:'El túnel'  tipo:'Audio Libro'  editorial:'Colihue'  anioEdicion:1980  colAutor:unaColAutor  isbn:'444-777772'  enBiblioteca:biblioteca2 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Tahan'  conNombre:'Malba').

unSistema crearLibroConNombre:'El hombre que calculaba'  tipo:'Impreso'  editorial:'Paidos'  anioEdicion:2020  colAutor:unaColAutor  isbn:'111-777772'  enBiblioteca:biblioteca2 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Hernandez'  conNombre:'José').

unSistema crearLibroConNombre:'Martin Fierro'  tipo:'Impreso'  editorial:'EDUBA'  anioEdicion:2000  colAutor:unaColAutor  isbn:'111-7347772'  enBiblioteca:biblioteca2 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Saint Exupery'  conNombre:'Antoine' ).

unSistema crearLibroConNombre:'El Principito'  tipo:'Impreso'  editorial:'El ateneo'  anioEdicion:2000  colAutor:unaColAutor  isbn:'1111-222'  enBiblioteca:biblioteca3 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Homero'  conNombre:'').

unSistema crearLibroConNombre:'La odisea'  tipo:'Electrónico'  editorial:'Utopia'  anioEdicion:1994  colAutor:unaColAutor  isbn:'333-2222'  enBiblioteca:biblioteca3 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Cortázar'  conNombre:'Rayuela').

unSistema crearLibroConNombre:'Rayuela'  tipo:'Audio Libro'  editorial:'Paidos'  anioEdicion:1950  colAutor:unaColAutor  isbn:'444-2222'  enBiblioteca:biblioteca3 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Borges'  conNombre:'Jorge').

unSistema crearLibroConNombre:'Ficciones'  tipo:'Impreso'  editorial:'Emecé'  anioEdicion:1960  colAutor:unaColAutor  isbn:'444-8888'  enBiblioteca:biblioteca3 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Zábato'  conNombre:'Ernesto').

unSistema crearLibroConNombre:'El túnel'  tipo:'Audio Libro'  editorial:'Colihue'  anioEdicion:1980  colAutor:unaColAutor  isbn:'444-777772'  enBiblioteca:biblioteca3 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Tahan'  conNombre:'Malba').

unSistema crearLibroConNombre:'El hombre que calculaba'  tipo:'Impreso'  editorial:'Paidos'  anioEdicion:2020  colAutor:unaColAutor  isbn:'111-777772'  enBiblioteca:biblioteca3 .

unaColAutor:=OrderedCollection new.
unaColAutor add:(Autor crearAutorConApellido:'Hernandez'  conNombre:'José').

unSistema crearLibroConNombre:'Martin Fierro'  tipo:'Impreso'  editorial:'EDUBA'  anioEdicion:2000  colAutor:unaColAutor  isbn:'111-7347772'  enBiblioteca:biblioteca3 .


sistema:=unSistema.
pantallaPrincipal setSistema:sistema.
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarModificarMaterialBibliografico [

	pantallaCambiarMatBibliogr
		ifNotNil: [ pantallaCambiarMatBibliogr show ]
		ifNil: [ 
			pantallaCambiarMatBibliogr := CambiarMaterial crearConSistema:
				                              sistema.
			self addMorph: pantallaCambiarMatBibliogr.
			pantallaCambiarMatBibliogr topLeft: self topLeft ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarOpcionesUsuario [

pantallaOpcionesUsuario show.

"pantallaAgregarBibliotecaUsuario :=nil.
pantallaPedirPrestamo :=nil.
pantallaDevolverPrestamo :=nil."

]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarOpcionesUsuarioConUsuario:elUsuario [

pantallaOpcionesUsuario ifNotNil: [ pantallaOpcionesUsuario show:elUsuario ] ifNil: [ 
	pantallaOpcionesUsuario:=OpcionesUsuario  crearOpcionesUsuarioConUsuario:elUsuario conSistema:sistema.
	self addMorph:pantallaOpcionesUsuario.
	pantallaOpcionesUsuario topLeft:self topLeft.
	 ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarPagarCuota [

	pantallaPagarUsuarioPlus
		ifNotNil: [ pantallaPagarUsuarioPlus show ]
		ifNil: [ 
			pantallaPagarUsuarioPlus := PagarUsuarioPlus crearConSistema:
				                            sistema.
			self addMorph: pantallaPagarUsuarioPlus.
			pantallaPagarUsuarioPlus topLeft: self topLeft ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarPantallaPrincipal [

pantallaPrincipal show.
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarPantallaRegistrarse [

	pantallaRegistrarse
		ifNil: [ 
			pantallaRegistrarse := Registrarse crearConSistema: sistema.
			self addMorph: pantallaRegistrarse.
			pantallaRegistrarse topLeft: self topLeft ]
		ifNotNil: [ pantallaRegistrarse show ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarPantallaRolAdministrador [
"Si no está creada la pantalla, se crea y se muestra;sino solo se vuelve a mostrar"
	rolAdmin ifNotNil: [ rolAdmin show ] ifNil: [ 
		rolAdmin := RolAdministrador crearConSistema: sistema.
		self addMorph: rolAdmin.
		rolAdmin topLeft: self topLeft ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarPantallaRolUsuario [

	rolUsuario ifNotNil: [ rolUsuario show ] ifNil: [ 
		rolUsuario := RolUsuario crearConSistema: sistema.
		self addMorph: rolUsuario.
		rolUsuario topLeft: self topLeft ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarPantallaVerUsuario [

	pantallaVerUsuario ifNotNil: [ pantallaVerUsuario show ] ifNil: [ 
		pantallaVerUsuario := VerUsuario crearConSistema: sistema.
		self addMorph: pantallaVerUsuario.
		pantallaVerUsuario topLeft: self topLeft ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarPedirPrestamoConUsuario: unUsuario [

	pantallaPedirPrestamo
		ifNotNil: [ pantallaPedirPrestamo show ]
		ifNil: [ 
			pantallaPedirPrestamo := PedirPrestamo
				                         crearConSistema: sistema
				                         conUsuario: unUsuario.
			self addMorph: pantallaPedirPrestamo.
			pantallaPedirPrestamo topLeft: self topLeft ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarSeleccionarVerBiblioteca [
pantallaSeleccionarVerBiblioteca ifNotNil: [ pantallaSeleccionarVerBiblioteca show ] ifNil: [ pantallaSeleccionarVerBiblioteca:=SeleccionarVerBiblioteca crearSeleccionarVerBibliotecaConSistema:sistema.
	self addMorph:pantallaSeleccionarVerBiblioteca.
	pantallaSeleccionarVerBiblioteca topLeft:self topLeft.  ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarSetDiasSuspensionImporte [

	pantallaSetDiasImporte
		ifNotNil: [ pantallaSetDiasImporte show ]
		ifNil: [ 
			pantallaSetDiasImporte := SetDiasImporte crearConSistema: sistema.
			self addMorph: pantallaSetDiasImporte.
			pantallaSetDiasImporte topLeft: self topLeft ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarUsuariosAtrasados [

	pantallaUsuariosAtrasados
		ifNotNil: [ pantallaUsuariosAtrasados show ]
		ifNil: [ 
			pantallaUsuariosAtrasados := VerUsuariosAtrasados crearConSistema:
				                             sistema.
			self addMorph: pantallaUsuariosAtrasados.
			pantallaUsuariosAtrasados topLeft: self topLeft ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarVerBiblioteca [

	pantallaVerBiblioteca
		ifNotNil: [ pantallaVerBiblioteca show ]
		ifNil: [ 
			pantallaVerBiblioteca := VerBiblioteca crearConSistema: sistema.
			self addMorph: pantallaVerBiblioteca.
			pantallaVerBiblioteca topLeft: self topLeft ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> cargarVerBiblioteca:unTipoUsuario [

	pantallaVerBiblioteca
		ifNotNil: [ pantallaVerBiblioteca show.pantallaVerBiblioteca setTipoUsuario: unTipoUsuario ]
		ifNil: [ 
			pantallaVerBiblioteca := VerBiblioteca crearConSistema: sistema.
			self addMorph: pantallaVerBiblioteca.
			pantallaVerBiblioteca topLeft: self topLeft.
			pantallaVerBiblioteca setTipoUsuario: unTipoUsuario .
			]
]

{ #category : #'as yet unclassified' }
MorphSistema >> inicializarPantallaPrincipal [

self width:1000.
self height:620.
pantallaPrincipal:=PantallaPrincipal crearPantallaPrincipalConSistema: sistema.
self addMorph:pantallaPrincipal.
pantallaPrincipal topLeft:self topLeft.
]

{ #category : #'as yet unclassified' }
MorphSistema >> inicializarSistema:unSistema [
|pantallaPrincipal|
sistema :=unSistema.
self width:1000.
self height:620.
pantallaPrincipal:=PantallaPrincipal crearPantallaPrincipalConSistema: unSistema.
self addMorph:pantallaPrincipal.
pantallaPrincipal topLeft:self topLeft.

self openInWindow .
]

{ #category : #'as yet unclassified' }
MorphSistema >> inicializarSistemaVacio [
sistema:=SistemaBilioteca crearSistemaBiblioteca  .
self inicializarPantallaPrincipal .
self openInWindow .
]

{ #category : #'as yet unclassified' }
MorphSistema >> mostrarAgregarBibliotecaAdministrador [

	agregarBibliotecaAdministrador
		ifNotNil: [ agregarBibliotecaAdministrador show ]
		ifNil: [ 
			agregarBibliotecaAdministrador := AgregarBibliotecaAdministrador 
				                                  crearConSistema: sistema.
			"owner siempre hace referencia a la instancia de MoprhSistema que lo contiene"
			self addMorph: agregarBibliotecaAdministrador.
			agregarBibliotecaAdministrador topLeft: self topLeft ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> mostrarBiblioteca:unaBiblioteca [

pantallaMostrarBiblioteca ifNotNil: [ pantallaMostrarBiblioteca show:unaBiblioteca ] ifNil: [ 
	pantallaMostrarBiblioteca := VerBiblioteca crearConSistema:sistema conBiblioteca:unaBiblioteca.
	self addMorph:pantallaMostrarBiblioteca.
	pantallaMostrarBiblioteca topLeft:self topLeft.
		 ]
]

{ #category : #'as yet unclassified' }
MorphSistema >> reiniciarPantallasUsuario [
pantallaAgregarBibliotecaUsuario :=nil.
pantallaPedirPrestamo :=nil.
pantallaDevolverPrestamo :=nil.
]

{ #category : #initialization }
MorphSistema >> setSistema:unSistema [
sistema:=unSistema.
]
