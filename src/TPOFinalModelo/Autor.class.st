Class {
	#name : #Autor,
	#superclass : #Object,
	#instVars : [
		'nombre',
		'apellido',
		'cantLibros'
	],
	#category : #TPOFinalModelo
}

{ #category : #'as yet unclassified' }
Autor class >> crearAutorConApellido:apellido conNombre: nombre [
|unAutor|

unAutor:=self new.
unAutor inicializarAutorConApellido:apellido conNombre: nombre.

^unAutor.
]

{ #category : #'set and get' }
Autor >> getApellido [ 
^apellido
]

{ #category : #'set and get' }
Autor >> getCantLibros [
^cantLibros
]

{ #category : #'set and get' }
Autor >> getNombre [
^nombre 
]

{ #category : #initialize }
Autor >> inicializarAutorConApellido:apellido2 conNombre: nombre2 [
apellido:=apellido2 .
nombre:=nombre2.
"Cuando el contador llega a cero, se borra el objeto del sistema"
cantLibros :=1.


]

{ #category : #applying }
Autor >> restarLibro [
"Cuando llega a cero se borra del sistema el autor"
cantLibros :=cantLibros-1
]

{ #category : #applying }
Autor >> sumarLibro [
cantLibros :=cantLibros+1
]

{ #category : #applying }
Autor >> verificarAutor:unAutor [
^ ((unAutor getNombre)=nombre) & ((unAutor getApellido)=apellido).
]
