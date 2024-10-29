Class {
	#name : #PrestamoConAudioLibro,
	#superclass : #PrestamoUnico,
	#category : #TPOFinalModelo
}

{ #category : #'as yet unclassified' }
PrestamoConAudioLibro class >> crearPrestamoAudioLibroConUsuario:usuario conColLibros:colLibros [

|prestamoAL|
prestamoAL:=self crearPrestamoUnicoConUsuario: usuario conColLibros: colLibros.
^prestamoAL.
]

{ #category : #'set and get' }
PrestamoConAudioLibro >> getColPrestamo [
|x|
x:=OrderedCollection new.
x add:self.
^x.
]

{ #category : #'set and get' }
PrestamoConAudioLibro >> getTipoPrestamo [
^'Prestamo con Audio Libro'
]

{ #category : #initialize }
PrestamoConAudioLibro >> inicializarConUsuario:unUsuario conColLibros:unaColLibros [
usuario:=unUsuario .
colLibros :=unaColLibros .
fechaInicio :=Date today.
]

{ #category : #applying }
PrestamoConAudioLibro >> verificarSuspension:tiempoDias [
"Verificar si corresponde suspensión"
^ fechaEntrega isAfter: (fechaInicio addDays: (tiempoDias/2)asInteger).
]
