Class {
	#name : #PrestamoDoble,
	#superclass : #Prestamo,
	#instVars : [
		'prestamo1',
		'prestamo2'
	],
	#category : #TPOFinalModelo
}

{ #category : #'as yet unclassified' }
PrestamoDoble class >> crearPrestamoDobleConPrestamo1:prestamo1 conPrestamo2:prestamo2 [

|prestamoDoble|
prestamoDoble:=self new.
prestamoDoble inicializarUnPrestamo:prestamo1 inicializarOtroPrestamo:prestamo2.
^prestamoDoble.


]

{ #category : #'as yet unclassified' }
PrestamoDoble class >> crearPrestamoDobleConPrestamo1:prestamo1 prestamo2:prestamo2 [

|prestamoDoble|
prestamoDoble:=self new.
prestamoDoble inicializarUnPrestamo:prestamo1 inicializarOtroPrestamo:prestamo2.
^prestamoDoble.


]

{ #category : #applying }
PrestamoDoble >> entregar [ 
prestamo1 entregar.
prestamo2 entregar.
]

{ #category : #applying }
PrestamoDoble >> estaEntregado [ 
"Si uno está entregado, ambos lo están"
^ prestamo1 estaEntregado 
]

{ #category : #'set and get' }
PrestamoDoble >> getColPrestamo [
|x|
x:=OrderedCollection new.
x add:prestamo1 .
x add:prestamo2 .
^x.
]

{ #category : #'set and get' }
PrestamoDoble >> getUsuario [
^prestamo1 getUsuario.
]

{ #category : #initialize }
PrestamoDoble >> inicializarUnPrestamo:unPrestamo inicializarOtroPrestamo:otroPrestamo [
prestamo1 :=unPrestamo .
prestamo2:=otroPrestamo .
]

{ #category : #initialization }
PrestamoDoble >> setFechaInicio: unaFecha [
prestamo1 setFechaInicio: unaFecha.
prestamo2 setFechaInicio: unaFecha.
]

{ #category : #applying }
PrestamoDoble >> verificarAtraso:margenDias [
^prestamo1 verificarAtraso:margenDias.
]

{ #category : #applying }
PrestamoDoble >> verificarSuspension:tiempoDias [
"Verificar si corresponde suspension"

^ (prestamo1 verificarSuspension:tiempoDias) | (prestamo2 verificarSuspension: tiempoDias).
]

{ #category : #applying }
PrestamoDoble >> verificarUsuario:unUsuario [
^ (prestamo1 getUsuario)=unUsuario.
]
