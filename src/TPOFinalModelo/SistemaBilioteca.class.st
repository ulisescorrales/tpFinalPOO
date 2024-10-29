Class {
	#name : #SistemaBilioteca,
	#superclass : #Object,
	#instVars : [
		'colUsuarios',
		'colBibliotecas',
		'colAutores'
	],
	#category : #TPOFinalModelo
}

{ #category : #'as yet unclassified' }
SistemaBilioteca class >> crearSistemaBiblioteca [

|sistema|
sistema:=self new.
sistema inicializarSistemaVacio.
^sistema.
]

{ #category : #'as yet unclassified' }
SistemaBilioteca class >> crearSistemaConBibliotecas:colBibliotecas conUsuarios:colUsuarios [

|sistema|
sistema:=self new.
sistema inicializarSistemConBibliotecas:colBibliotecas usuarios:colUsuarios.
^sistema.
]

{ #category : #applying }
SistemaBilioteca >> cambiarModalidadUsuario:unUsuario [

|nuevoUsuario exito|
"Buscar el usuario"

	exito:=true.
	"Crear otro objeto con las mismas variables de instancia"
	nuevoUsuario := unUsuario cambiarTipoUsuario ."M.P. (sustitución)"
	"Remover viejo objeto y agregar el nuevo"	
	colUsuarios remove:unUsuario.
	colUsuarios addFirst:nuevoUsuario.
	
	unUsuario changed:nuevoUsuario.
^exito.
]

{ #category : #creating }
SistemaBilioteca >> crearBibliotecaConid:unId  direccion:unaDir  nombre:unNombre  telefono:unTel  representante: unRpr tiempoDevolucion: unTiempo [

|unaBiblioteca exito|
exito:=(self existeIdBiblioteca: unId) not.
exito ifTrue:[
	unaBiblioteca :=Biblioteca crearBibliotecaConid:unId direccion:unaDir  nombre:unNombre  telefono:
	unTel representante: unRpr  tiempoDevolucion: unTiempo.
	colBibliotecas addFirst: unaBiblioteca.
	self changed:unaBiblioteca
	].
"Avisar a los dependientes del cambio generado en sistema"
^exito
]

{ #category : #creating }
SistemaBilioteca >> crearLibroConNombre: nombre tipo:tipo  editorial:editorial  anioEdicion: anioEdicion colAutor: colAutores2 isbn: isbn enBiblioteca:unaBiblioteca [

|exito colAutoresDef|
colBibliotecas detect:[:b|b=unaBiblioteca] ifFound:[:laBiblioteca|
	"Ver si los autorse son nuevos o ya existían en el sistema"
	colAutoresDef :=self verificarAutores:colAutores2.
	exito:=laBiblioteca crearLibroConNombre:nombre  tipo:tipo  editorial:editorial  anioEdicion: 	anioEdicion  autor:colAutoresDef isbn: isbn.
	]
.
^exito.

]

{ #category : #creating }
SistemaBilioteca >> crearUsuarioConDNI: dni nombre:nombre apellido:apellido contrasenia:contrasenia [
|unUsuario exito|
exito:=(self existeUsuario:dni) not.

exito ifTrue: [ 
	unUsuario:=Usuario crearUsuarioConDNI: dni nombre:nombre  apellido:apellido  contrasenia:contrasenia. 
	colUsuarios addFirst:unUsuario.
	self changed:unUsuario.
	].
^exito
]

{ #category : #creating }
SistemaBilioteca >> crearUsuarioPlusConDNI: dni nombre:nombre apellido:apellido contrasenia:contrasenia [
|unUsuarioPlus exito|
exito:=(self existeUsuario: dni)not.
exito ifTrue: [ 
	unUsuarioPlus :=UsuarioPlus crearUsuarioPlusConDNI: dni nombre:nombre  apellido:apellido  	contrasenia:contrasenia
	.colUsuarios addFirst:unUsuarioPlus.
	self changed:unUsuarioPlus.
	].
^exito
]

{ #category : #applying }
SistemaBilioteca >> existeIdBiblioteca:unId [
|existe|
existe:=false.
colBibliotecas detect:[:b|b comprobarId: unId] ifFound:[existe:=true].
^existe.
]

{ #category : #applying }
SistemaBilioteca >> existeUsuario:unDni [
|existe|
existe:=false.
colUsuarios detect:[:usuario| usuario verificarDni: unDni] ifFound:[existe:=true].
^existe
]

{ #category : #applying }
SistemaBilioteca >> generarListadoDeUsuariosAtrasados [

	| listaAtrasados tupla bibliotecasConAtraso |
	listaAtrasados := OrderedCollection new.

	colUsuarios do: [ :usuario | "Traer bibliotecas con atrasdo para el usuario"
		bibliotecasConAtraso := usuario verificarBibliotecasConAtraso.
		"Si existe entonces generar una tupla y agregar al listado a retornar"

		bibliotecasConAtraso do: [ :biblioteca | 
			tupla := OrderedCollection new.
			tupla add: usuario.
			tupla add: biblioteca.
			listaAtrasados addFirst: tupla ] ].
	^ listaAtrasados
]

{ #category : #'set and get' }
SistemaBilioteca >> getBiblioteca:id [
^colBibliotecas detect:[:b|((b getId) asString) asInteger=id]
]

{ #category : #'set and get' }
SistemaBilioteca >> getBibliotecas [
^colBibliotecas
]

{ #category : #'set and get' }
SistemaBilioteca >> getDiasSuspension [

^Suspension getDiasSuspension.
]

{ #category : #'set and get' }
SistemaBilioteca >> getLibrosDeBiblioteca:id [

|colLibros|
colBibliotecas detect: [:biblioteca| biblioteca verificarIdBiblioteca: id ] ifFound: [:biblioteca|
		colLibros :=biblioteca getLibros.
	  ].
^colLibros .
]

{ #category : #'as yet unclassified' }
SistemaBilioteca >> getUltimaBiblioteca [
^colBibliotecas at:1.
]

{ #category : #'set and get' }
SistemaBilioteca >> getUsuario:unDNI [
|retornar|
colUsuarios detect:[:usuario| usuario verificarDni:unDNI] ifFound:[:elUsuario|retornar:=elUsuario]ifNone:[retornar:=nil].
^  retornar.
]

{ #category : #'set and get' }
SistemaBilioteca >> getUsuarios [
^colUsuarios .
]

{ #category : #'set and get' }
SistemaBilioteca >> getUsuariosPlus [
^ colUsuarios select:[:usuario|usuario esUsuarioPlus].
]

{ #category : #initialization }
SistemaBilioteca >> inicializarSistemConBibliotecas:colBibliotecas2  usuarios:colUsuarios2 [

colBibliotecas := colBibliotecas2 .
colUsuarios :=colUsuarios2 .
colAutores :=OrderedCollection new.
]

{ #category : #initialization }
SistemaBilioteca >> inicializarSistemaVacio [
colUsuarios:=OrderedCollection new.
colBibliotecas:=OrderedCollection new.
colAutores:=OrderedCollection new.
]

{ #category : #deleting }
SistemaBilioteca >> quitarUnLibro:isbn  deBiblioteca: unaBiblioteca [
|elLibro|
colBibliotecas detect:[:biblioteca|biblioteca=unaBiblioteca] ifFound:[:laBiblioteca|
	elLibro:=laBiblioteca quitarLibro:isbn.
	].
"Eliminar autor del sistema si ya no posee libros en el sistema"
elLibro getAutores do:[:autor|
	autor restarLibro .
	((autor getCantLibros) =0) ifTrue:[
		colAutores remove:autor.
		]
	].
]

{ #category : #initialization }
SistemaBilioteca >> setDiasSuspension: cantDias [

Suspension setDiasSuspension: cantDias.
]

{ #category : #applying }
SistemaBilioteca >> verificarAutores:colAutores2 [
"Retornar una colección con autores que existen en el sistema, si no existían se reemplazan por
objetos nuevos"
|nuevoAutor nuevaColeccion|

nuevaColeccion:=colAutores2 collect:[:autor|
	colAutores detect:[:a|a verificarAutor:autor]
	ifFound:[:elAutor|nuevoAutor:=elAutor. 
		nuevoAutor sumarLibro]
	ifNone:[nuevoAutor:=autor.
			colAutores addFirst:autor].
	nuevoAutor
].
^nuevaColeccion.
]
