Class {
	#name : #Biblioteca,
	#superclass : #Object,
	#instVars : [
		'id',
		'direccion',
		'nombre',
		'telefono',
		'representante',
		'colPrestamos',
		'colLibros',
		'tiempoDevolucionDias'
	],
	#category : #TPOFinalModelo
}

{ #category : #'as yet unclassified' }
Biblioteca class >> crearBibliotecaConid:id direccion:direccion nombre:nombre telefono:telefono representante:representante  colLibros:colLibros tiempoDevolucion:tiempo [

|biblioteca|
biblioteca:=self new.
biblioteca inicializarBibliotecaConid: id direccion:direccion  nombre:nombre  telefono:telefono  representante:representante  libros:colLibros  tiempoDevolucion: tiempo.
^biblioteca.
]

{ #category : #'as yet unclassified' }
Biblioteca class >> crearBibliotecaConid:id direccion:direccion nombre:nombre telefono:telefono representante:representante colPrestamos:colPrestamos colLibros:colLibros tiempoDevolucion:tiempo [

|biblioteca|
biblioteca:=self new.
biblioteca inicializarBibliotecaConid: id direccion:direccion  nombre:nombre  telefono:telefono  representante:representante  prestamos:colPrestamos  libros:colLibros  tiempoDevolucion: tiempo.
^biblioteca.
]

{ #category : #'as yet unclassified' }
Biblioteca class >> crearBibliotecaConid:id direccion:direccion nombre:nombre telefono:telefono representante:representante  tiempoDevolucion:tiempo [

|biblioteca|
biblioteca:=self new.
biblioteca inicializarBibliotecaConid: id direccion:direccion  nombre:nombre  telefono:telefono  representante:representante tiempoDevolucion: tiempo.
^biblioteca.
]

{ #category : #applying }
Biblioteca >> comprobarId:unId [
^unId= id.
]

{ #category : #applying }
Biblioteca >> crearLibroConNombre: nombre2 tipo: tipo editorial: editorial anioEdicion: anioEdicion autor: colAutores2 isbn: isbn [

	| exito nuevoLibro|
	exito := true.
	nuevoLibro :=Libro
			 crearLibroConNombre: nombre2
			 tipo: tipo
			 editorial: editorial
			 anioEdicion: anioEdicion
			 autores: colAutores2
			 isbn: isbn.
	"Puede existir más de un ejemplar de libro"
	colLibros addFirst: (nuevoLibro ).
	self changed:nuevoLibro.
	^ exito
]

{ #category : #applying }
Biblioteca >> devolverPrestamo:unUsuario [
|exito|
exito:=false.

colPrestamos detect:[:prestamo|prestamo verificarUsuario:unUsuario]
ifFound:[:elPrestamo| (elPrestamo estaEntregado) 
	ifFalse:[
		exito:=true.
		elPrestamo entregar.
		"Verificar si corresponde generar una suspensión en caso que la entrega esté fuera de término"
		(elPrestamo verificarSuspension:tiempoDevolucionDias) ifTrue:[
			unUsuario crearSuspension.
			].		
		]
	].
^exito.
]

{ #category : #'set and get' }
Biblioteca >> getId [
^id
]

{ #category : #'set and get' }
Biblioteca >> getLibros [
^colLibros.
]

{ #category : #'set and get' }
Biblioteca >> getLibrosSinPrestar [
"Elegir aquellos libros que todavía no fueron prestados"
^colLibros select:[:libro|(libro getPrestado)=false]
]

{ #category : #'set and get' }
Biblioteca >> getNombre [
^nombre.
]

{ #category : #'set and get' }
Biblioteca >> getPrestamos [
"Devuelve la totalidad de los préstamos"
^colPrestamos .
]

{ #category : #'set and get' }
Biblioteca >> getPrestamosActivos [ 
"Retornar solo aquellos préstamos activos, de cualquier usuario"
|colPrestamosActivos|
colPrestamosActivos :=OrderedCollection new.
(colPrestamos select:[:prestamo|(prestamo estaEntregado) =false]) do:[:prestamo|(prestamo getColPrestamo) do:[:prestamo2|colPrestamosActivos add:prestamo2]].
colPrestamosActivos do:[:prestamo|Transcript show:prestamo;cr].
^colPrestamosActivos .
]

{ #category : #'set and get' }
Biblioteca >> getPrestamosUsuario:unUsuario [
"Encontrar el primer préstamo con el usuario y ver si está entregado, retornarlo"
|retornar|
colPrestamos detect:[:prestamo| prestamo verificarUsuario:unUsuario] 
ifFound:[:elPrestamo|(elPrestamo estaEntregado) 
	ifFalse:[ retornar:=elPrestamo] 
	ifTrue:[retornar:=nil]] 
ifNone:[retornar:=nil].
^retornar
]

{ #category : #'set and get' }
Biblioteca >> getRepresentante [
^representante.
]

{ #category : #'set and get' }
Biblioteca >> getTelefono [
^telefono.
]

{ #category : #'set and get' }
Biblioteca >> getTiempoDevolucionDias [
^tiempoDevolucionDias .
]

{ #category : #initialize }
Biblioteca >> inicializarBibliotecaConid:id2 direccion:dir nombre:nombre2 telefono:tel representante:repr  libros:colLibros2 tiempoDevolucion:tiempoDias [

id :=id2 .
direccion :=dir.
nombre :=nombre2.
telefono :=tel.
representante :=repr .
colLibros :=colLibros2 .
colPrestamos :=OrderedCollection new.
tiempoDevolucionDias :=tiempoDias.
]

{ #category : #initialize }
Biblioteca >> inicializarBibliotecaConid: id2 direccion:direccion2  nombre:nombre2  telefono:telefono2  representante:representante2  tiempoDevolucion: tiempo2 [

id:=id2.
nombre:=nombre2.
direccion :=direccion2 .
telefono:=telefono2.
representante :=representante2 .
tiempoDevolucionDias :=tiempo2.
colLibros:=OrderedCollection new.
colPrestamos :=OrderedCollection  new.
]

{ #category : #applying }
Biblioteca >> poseePrestamo: unUsuario [

	"Comprobar si un usuario posee algún préstamo activo"

	| posee |
	colPrestamos
		detect: [ :prestamo | prestamo verificarUsuario: unUsuario ]
		ifFound: [ :elPrestamo | 
			elPrestamo estaEntregado
				ifTrue: [ posee := false ]
				ifFalse: [ posee := true ] ]
		ifNone: [ posee := false ].

	^ posee
]

{ #category : #applying }
Biblioteca >> quitarLibro:isbn [

colLibros detect:[:libro|libro verificarISBN: isbn] 
	ifFound:[:elLibro|colLibros remove:elLibro].
]

{ #category : #accessing }
Biblioteca >> registrarPrestamoConUsuario: unUsuario conLibros: unaColLibros [

	| hayPrestado exito poseePrestamo cuotaAlDia puedePedir |
	exito := false.
	cuotaAlDia := false.
	puedePedir := false.

	"Comprobar si algún libro ya está prestado"
	unaColLibros
		detect: [ :libro | libro getPrestado ]
		ifFound: [ hayPrestado := true ]
		ifNone: [ hayPrestado := false ].
	"Comprobar si el usuario ya posee un prestado activo"
	hayPrestado ifFalse: [ 
		poseePrestamo := self poseePrestamo: unUsuario.

		poseePrestamo ifFalse: [ 
			puedePedir := unUsuario puedePedir: unaColLibros.
			puedePedir ifTrue: [ "Si puede pedir (definitivamente) entonces subdivir la colección según el tipo de usuario"
				colPrestamos addFirst: (unUsuario armarPrestamo: unaColLibros).
				exito := true.
				"Marcar cada libro como prestado en su atributo"
				unaColLibros do: [ :libro | libro prestar ] ] ] ].
	^ exito
]

{ #category : #applying }
Biblioteca >> verificarAtrasado: unUsuario [

	"Encontrar el últio préstamo a un usuario y comprobar que no esté fuera de fecha, si no existe o fue entregado entonces no hay atraso"

	| estaAtrasado |
	colPrestamos
		detect: [ :prestamo | prestamo verificarUsuario: unUsuario ]
		ifFound: [ :elPrestamo | 
			estaAtrasado := elPrestamo verificarAtraso: tiempoDevolucionDias ]
		ifNone: [ estaAtrasado := false ].
	^ estaAtrasado
]

{ #category : #applying }
Biblioteca >> verificarIdBiblioteca:idBiblioteca [
^ id=idBiblioteca
]
