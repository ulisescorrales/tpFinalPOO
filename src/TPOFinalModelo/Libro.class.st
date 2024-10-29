Class {
	#name : #Libro,
	#superclass : #Object,
	#instVars : [
		'isbn',
		'nombre',
		'colAutores',
		'anioEdicion',
		'editorial',
		'tipo',
		'prestado'
	],
	#category : #TPOFinalModelo
}

{ #category : #'as yet unclassified' }
Libro class >> crearLibroConNombre:nombre tipo:tipo editorial:editorial anioEdicion:anio autores:colAutor isbn:isbn [
"Pueden existir más de un ejemplar con el mismo identificador en la biblioteca"
|libro|
libro:= self new.
libro inicializarLibroConNombre:nombre tipo:tipo editorial:editorial anioEdicion:anio autor:colAutor isbn:isbn.
^libro
]

{ #category : #applying }
Libro >> entregar [
prestado:=false.
]

{ #category : #'set and get' }
Libro >> getAnioEdicion [
^anioEdicion 
]

{ #category : #'set and get' }
Libro >> getAutores [
^colAutores .
]

{ #category : #'set and get' }
Libro >> getEditorial [
^editorial
]

{ #category : #'set and get' }
Libro >> getISBN [
^isbn.
]

{ #category : #'set and get' }
Libro >> getNombre [ 
^nombre
]

{ #category : #'set and get' }
Libro >> getPrestado [
^prestado.
]

{ #category : #'set and get' }
Libro >> getTipo [
^tipo 
]

{ #category : #abstract }
Libro >> inicializarLibroConNombre:nombre2 tipo:tipo2 editorial:editorial2 anioEdicion:anio2 autor:colAutor2 isbn:isbn2 [
nombre :=nombre2.
tipo :=tipo2.
prestado:=false.
editorial :=editorial2 .
anioEdicion :=anio2 .
colAutores :=colAutor2 .
isbn:=isbn2 "Identificador único"
]

{ #category : #applying }
Libro >> prestar [
prestado :=true.
]

{ #category : #applying }
Libro >> verificarISBN:unISBN [
^isbn=unISBN .
]
