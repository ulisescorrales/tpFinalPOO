Class {
	#name : #UsuarioPlus,
	#superclass : #Usuario,
	#instVars : [
		'colCuotas'
	],
	#category : #TPOFinalModelo
}

{ #category : #'as yet unclassified' }
UsuarioPlus class >> crearUsuarioPlusConDNI: dni nombre:nombre apellido:apellido contrasenia:contrasenia [

|usuario|
"Definido en Usuario"
usuario:= self crearUsuarioConDNI: dni nombre:nombre apellido:apellido contrasenia:contrasenia.
"Inicializador propio"
usuario inicializarColCuotas.
^usuario.
]

{ #category : #creating }
UsuarioPlus >> armarPrestamo: colLibros [

	"Ya se ha comprobado previamente que solo existen dos tipos de libros por lo tanto existirán solo 2 préstamos como máximo aunque se declaren 3 variables de préstamo"

	| colImpreso colElectronico colAudioLibro prestamoImpreso prestamoElectronico prestamoAudioLibro cantPrestamos colPrestamo retornar |
	cantPrestamos := 0.
	colImpreso := OrderedCollection new.
	colElectronico := OrderedCollection new.
	colAudioLibro := OrderedCollection new.
	colPrestamo := OrderedCollection new.
	"Recoger cada libro en la colección que corresponda"
	colLibros do: [ :libro | 
		libro getTipo = 'Impreso'
			ifTrue: [ colImpreso addFirst: libro ]
			ifFalse: [ 
				libro getTipo = 'Electrónico'
					ifTrue: [ colElectronico addFirst: libro ]
					ifFalse: [ 
						libro getTipo = 'Audio Libro' ifTrue: [ 
							colAudioLibro addFirst: libro ] ] ] ].
	"Armar el préstamo individual correspondiente"
	colImpreso isNotEmpty ifTrue: [ 
		prestamoImpreso := PrestamoSinAudioLibro
			                   crearPrestamoSinAudioLibroConUsuario: self
			                   conColLibros: colImpreso.
		cantPrestamos := cantPrestamos + 1.
		colPrestamo addFirst: prestamoImpreso ].
	colElectronico isNotEmpty ifTrue: [ 
		prestamoElectronico := PrestamoSinAudioLibro
			                       crearPrestamoSinAudioLibroConUsuario: self
			                       conColLibros: colElectronico.
		cantPrestamos := cantPrestamos + 1.
		colPrestamo addFirst: prestamoElectronico ].
	colAudioLibro isNotEmpty ifTrue: [ 
		prestamoAudioLibro := PrestamoConAudioLibro
			                      crearPrestamoAudioLibroConUsuario: self
			                      conColLibros: colAudioLibro.
		cantPrestamos := cantPrestamos + 1.
		colPrestamo addFirst: prestamoAudioLibro ].
	"Si existen dos préstamos entonces encapsularlos en un préstamo doble, sino devolver uno simple"
	cantPrestamos = 2
		ifTrue: [ 
			retornar := PrestamoDoble crearPrestamoDobleConPrestamo1:(colPrestamo at: 1)  conPrestamo2: (colPrestamo at: 2) ]
		ifFalse: [ retornar := colPrestamo at: 1 ].
	^ retornar
]

{ #category : #applying }
UsuarioPlus >> cambiarTipoUsuario [ 

|unUsuario|
unUsuario:= Usuario new.
unUsuario inicializarUsuarioConDNI: dni nombre:nombre  apellido:apellido  contrasenia: contrasenia .
^unUsuario .
]

{ #category : #applying }
UsuarioPlus >> cuotaAlDia [
|ultimaCuota estaAlDia|
estaAlDia :=false.
colCuotas ifNotEmpty: [ 
	ultimaCuota:=colCuotas at:1.
	estaAlDia:= ultimaCuota estaAlDia. ].
^estaAlDia 
]

{ #category : #applying }
UsuarioPlus >> esUsuarioPlus [ 
^true.
]

{ #category : #'set and get' }
UsuarioPlus >> getTipoUsuario [
^'Usuario Plus'
]

{ #category : #initialize }
UsuarioPlus >> inicializarColCuotas [
colCuotas := OrderedCollection new.
]

{ #category : #applying }
UsuarioPlus >> pagarCuota [

	| cuota exito |
	exito := false.
	self cuotaAlDia ifFalse: [ 
		exito := true.
		cuota := Cuota crearCuotaConImporte: Cuota getValorCuota.
		colCuotas addFirst: cuota ].
	^ exito
]

{ #category : #applying }
UsuarioPlus >> puedePedir: unaColLibros [
|puedePedir|
"Se aplica refinamiento"
puedePedir:=super puedePedir:unaColLibros.
"Se agrega la verificación de la cuota al día"
puedePedir ifFalse:[puedePedir:=self cuotaAlDia ].
^puedePedir.
]

{ #category : #applying }
UsuarioPlus >> puedePedirTipoLibro: unaColLibros [

	| puedePedir cantImpreso cantElectronico cantAudioLibro tipo |
	cantImpreso := 0.
	cantElectronico := 0.
	cantAudioLibro := 0.
	"Cuenta la cantidad de tipos de libros. Si existen 3 tipos de libros distintos entonces se rechaza. Puede pedir audio libros"
	unaColLibros
 			detect: [ :libro | 
			tipo := libro getTipo.
			tipo = 'Audio Libro'
				ifTrue: [ cantAudioLibro := cantAudioLibro + 1 ]
				ifFalse: [ 
					tipo = 'Impreso'
						ifTrue: [ cantImpreso := cantImpreso + 1 ]
						ifFalse: [ 
							tipo = 'Electrónico' ifTrue: [ 
								cantElectronico := cantElectronico + 1 ] ] ].
			(cantImpreso > 0) & (cantElectronico > 0) & (cantAudioLibro > 0) ]
		ifFound: [ puedePedir := false ]
		ifNone: [ puedePedir := true ].
	^ puedePedir
]
