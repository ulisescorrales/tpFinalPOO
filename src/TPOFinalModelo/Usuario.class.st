Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'dni',
		'nombre',
		'apellido',
		'contrasenia',
		'colBibliotecas',
		'colSuspensiones'
	],
	#category : #TPOFinalModelo
}

{ #category : #'as yet unclassified' }
Usuario class >> crearUsuarioConDNI: dni nombre:nombre apellido:apellido contrasenia:contrasenia [

|usuario|
usuario:=self new.
usuario inicializarUsuarioConDNI: dni nombre:nombre apellido:apellido contrasenia:contrasenia.
^usuario.
]

{ #category : #applying }
Usuario >> agregarBiblioteca:biblioteca [
colBibliotecas add:biblioteca.
self changed.
Transcript show:'changed';cr.
]

{ #category : #applying }
Usuario >> agregarSuspension:suspension [
colSuspensiones add:suspension.
]

{ #category : #creating }
Usuario >> armarPrestamo: unaColLibros [

	| prestamo |
	prestamo := PrestamoSinAudioLibro
		            crearPrestamoSinAudioLibroConUsuario: self
		            conColLibros: unaColLibros.

	^ prestamo
]

{ #category : #applying }
Usuario >> cambiarTipoUsuario [
|unUsuarioPlus|
unUsuarioPlus:=UsuarioPlus new.
unUsuarioPlus inicializarUsuarioConDNI: dni nombre:nombre  apellido:apellido  contrasenia: contrasenia.
unUsuarioPlus inicializarColCuotas.
^unUsuarioPlus. 
]

{ #category : #creating }
Usuario >> crearSuspension [

colSuspensiones addFirst: Suspension crearSuspension.
]

{ #category : #applying }
Usuario >> esUsuarioPlus [
^false.
]

{ #category : #applying }
Usuario >> estaSuspendido [
|estaSuspendido|
estaSuspendido:=false.
"Si tiene suspensiones, verificar si la última se encuentra activa al día de hoy"
colSuspensiones ifNotEmpty: [
	.estaSuspendido := (colSuspensiones at:1) verificarSuspension ].

^estaSuspendido.
]

{ #category : #initialize }
Usuario >> getApellido [
^apellido.
]

{ #category : #initialize }
Usuario >> getBibliotecas [ 
^colBibliotecas .
]

{ #category : #'set and get' }
Usuario >> getBibliotecasConPrestamoActivo [

^ colBibliotecas select:[:biblioteca|biblioteca poseePrestamo: self].
]

{ #category : #'set and get' }
Usuario >> getBibliotecasSinPrestamo [
^colBibliotecas select:[:biblioteca|(biblioteca poseePrestamo: self)not].
]

{ #category : #initialize }
Usuario >> getContrasenia [
^contrasenia.
]

{ #category : #initialize }
Usuario >> getDNI [ 
^dni.
]

{ #category : #'set and get' }
Usuario >> getFinSuspension [
|fechaFin|
self estaSuspendido ifTrue:[fechaFin:=(colSuspensiones at:1)getFechaFin].
^fechaFin.
]

{ #category : #initialize }
Usuario >> getNombre [
^nombre.
]

{ #category : #'set and get' }
Usuario >> getPrestamos [
"Retornar una colección de prestamos activos en el sistema"
|temp colPrestamos|
colPrestamos:=OrderedCollection new.
colBibliotecas do:[:biblioteca|
	temp:=biblioteca getPrestamosUsuario:self.
	temp ifNotNil:[colPrestamos add:temp].
].
^colPrestamos.
]

{ #category : #initialize }
Usuario >> getTipoUsuario [
^'Usuario normal'
]

{ #category : #initialize }
Usuario >> inicializarUsuarioConDNI: dni2 nombre:nombre2 apellido:apellido2 contrasenia:contrasenia2 [

dni:= dni2.
nombre:=nombre2.
apellido:=apellido2.
contrasenia:=contrasenia2.
colSuspensiones :=OrderedCollection new.
colBibliotecas :=OrderedCollection new.

]

{ #category : #applying }
Usuario >> puedePedir: unaColLibros [

	| puedePedir aux tamanioCorrecto |
	tamanioCorrecto := unaColLibros size > 0 & (unaColLibros size < 6).
	"Si el tamaño de unaColLibros es el correcto, ver si el usuario puede realizar un préstamo con los libros que tiene la colección"
	tamanioCorrecto
		ifTrue: [ puedePedir := self puedePedirTipoLibro: unaColLibros ]
		ifFalse: [ puedePedir := false ].
	"Comprobar si está suspendido"
	puedePedir ifTrue: [ puedePedir := self estaSuspendido not ].
	^ puedePedir
]

{ #category : #applying }
Usuario >> puedePedirTipoLibro:unaColLibros [

|puedePedir aux|
aux:=(unaColLibros at:1) getTipo.
"Si hay dos tipos de libros distintos o un audilibro entonces el pedido es rechazado"
unaColLibros detect:[:libro| (libro getTipo~=aux) | (libro getTipo = 'Audio Libro')] ifFound: [ puedePedir:=false ] ifNone:[puedePedir := true].
^puedePedir.
]

{ #category : #'set and get' }
Usuario >> setBibliotecas:colBibliotecas2 [
colBibliotecas:=colBibliotecas2 .
self changed.
]

{ #category : #applying }
Usuario >> validarContrasenia:unaContrasenia [
^(contrasenia)asString=unaContrasenia .
]

{ #category : #applying }
Usuario >> verificarAtrasoEnBiblioteca:unaBiblioteca [
|estaAtrasado|
estaAtrasado := unaBiblioteca verificarAtrasado:self.
^estaAtrasado .

]

{ #category : #applying }
Usuario >> verificarBibliotecasConAtraso [
"Retorna la colección de bibliotecas con atraso"
|colBibliotecaAtrasado estaAtrasado|

colBibliotecaAtrasado := colBibliotecas select:[:biblioteca|
	estaAtrasado := self verificarAtrasoEnBiblioteca:biblioteca].

^colBibliotecaAtrasado.
]

{ #category : #applying }
Usuario >> verificarDni:unDni [
^dni=unDni.
]
