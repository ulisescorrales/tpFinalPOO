Class {
	#name : #PrestamoUnico,
	#superclass : #Prestamo,
	#instVars : [
		'colLibros',
		'fechaInicio',
		'fechaEntrega',
		'usuario'
	],
	#category : #TPOFinalModelo
}

{ #category : #'as yet unclassified' }
PrestamoUnico class >> crearPrestamoUnicoConUsuario: usuario conColLibros:unaColLibros [
|prestamo|
prestamo:=self new.
prestamo inicializarConUsuario:usuario conColLibros:unaColLibros.
^prestamo.
]

{ #category : #applying }
PrestamoUnico >> entregar [
fechaEntrega:= Date today.
"Indicar que los libros ya no están prestados"
colLibros do:[:libro|libro entregar].
]

{ #category : #applying }
PrestamoUnico >> estaEntregado [
^ (fechaEntrega=nil)not.
]

{ #category : #'set and get' }
PrestamoUnico >> getColLibros [
^colLibros  .
]

{ #category : #'set and get' }
PrestamoUnico >> getFechaEntrega [
|retornar|
fechaEntrega ifNotNil: [ retornar:=fechaEntrega asString ] ifNil: [ retornar:='-' ].
^ retornar .
]

{ #category : #'set and get' }
PrestamoUnico >> getFechaInicio [
^fechaInicio asString .
]

{ #category : #'set and get' }
PrestamoUnico >> getUsuario [
^usuario.
]

{ #category : #initialize }
PrestamoUnico >> inicializarConUsuario:unUsuario conColLibros:unaColLibros [
self subclassResponsibility .
]

{ #category : #'set and get' }
PrestamoUnico >> setFechaInicio:unaFecha [
"Método para realizar debugging para saber si funciona correctamente la creación de suspensiones y
detección de usuarios con préstamos atrasados"
fechaInicio :=unaFecha.
]

{ #category : #applying }
PrestamoUnico >> verificarAtraso:margenDias [
^ (fechaEntrega=nil) & ((fechaInicio addDays: margenDias)<(Date today))
]

{ #category : #applying }
PrestamoUnico >> verificarUsuario:unUsuario [
^usuario=unUsuario 
]
