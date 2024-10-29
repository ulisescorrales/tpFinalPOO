Class {
	#name : #Cuota,
	#superclass : #Object,
	#instVars : [
		'fechaIn',
		'fechaFin',
		'importe'
	],
	#classVars : [
		'VALOR_CUOTA'
	],
	#category : #TPOFinalModelo
}

{ #category : #'as yet unclassified' }
Cuota class >> crearCuotaConImporte:unImporte [
|cuota|
cuota:=self new.
cuota inicializarCuotaConImporte:unImporte.
"Valor por defecto"
VALOR_CUOTA ifNil:[VALOR_CUOTA:=1000].
^cuota.
]

{ #category : #'as yet unclassified' }
Cuota class >> getValorCuota [ 
^VALOR_CUOTA 
]

{ #category : #initialization }
Cuota class >> setValorCuota:valor [
VALOR_CUOTA :=valor.
]

{ #category : #applying }
Cuota >> estaAlDia [
|hoy|
hoy:= Date today.

^ hoy<=fechaFin .
]

{ #category : #initialize }
Cuota >> inicializarCuotaConImporte:unImporte [

fechaIn := Date today .
fechaFin:= fechaIn addMonths: 1.
importe :=unImporte.
]
