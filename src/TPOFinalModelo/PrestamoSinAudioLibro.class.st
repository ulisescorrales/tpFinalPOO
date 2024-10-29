Class {
	#name : #PrestamoSinAudioLibro,
	#superclass : #PrestamoUnico,
	#category : #TPOFinalModelo
}

{ #category : #'as yet unclassified' }
PrestamoSinAudioLibro class >> crearPrestamoSinAudioLibroConUsuario:usuario conColLibros:colLibros [

|prestamoAL|
prestamoAL:=self crearPrestamoUnicoConUsuario: usuario conColLibros: colLibros.
^prestamoAL.
]

{ #category : #'set and get' }
PrestamoSinAudioLibro >> getColPrestamo [
|x|
x:=OrderedCollection new.
x add:self.
^x.
]

{ #category : #'set and get' }
PrestamoSinAudioLibro >> getTipoPrestamo [
^'Prestamo sin Audio Libro'
]

{ #category : #initialize }
PrestamoSinAudioLibro >> inicializarConUsuario:unUsuario conColLibros:unaColLibros [
usuario:=unUsuario .
colLibros :=unaColLibros .
fechaInicio :=Date today.
]

{ #category : #applying }
PrestamoSinAudioLibro >> verificarSuspension:tiempoDias [
"Verificar si corresponde suspensión"
^ (fechaEntrega isAfter:  (fechaInicio addDays: tiempoDias ))
]
