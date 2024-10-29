Class {
	#name : #Suspension,
	#superclass : #Object,
	#instVars : [
		'fechaIn',
		'fechaFin'
	],
	#classVars : [
		'DIAS_SUSP'
	],
	#category : #TPOFinalModelo
}

{ #category : #'as yet unclassified' }
Suspension class >> crearSuspension [

|unaSuspension|

unaSuspension:=self new.
"Valor predeterminado, luego se puede modificar con un setter"
DIAS_SUSP ifNil:[DIAS_SUSP:=7].
unaSuspension inicializarSuspension.
^unaSuspension.
]

{ #category : #'as yet unclassified' }
Suspension class >> getDiasSuspension [ 
^DIAS_SUSP .
]

{ #category : #initialization }
Suspension class >> setDiasSuspension:cantDias [

DIAS_SUSP :=cantDias.
]

{ #category : #'set and get' }
Suspension >> getFechaFin [
^fechaFin
]

{ #category : #initialize }
Suspension >> inicializarSuspension [

fechaIn:= Date today.
fechaFin:=(Date today) addDays: Suspension getDiasSuspension.
]

{ #category : #applying }
Suspension >> verificarSuspension [
^ fechaFin >=Date new.
]
