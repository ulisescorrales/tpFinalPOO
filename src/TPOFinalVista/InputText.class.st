"
Clase que permite hacer uso de las teclas ""supr"",""delete"",""inicio,""fin"",""Re Pág"", ""Av Pág"" y las teclas con flechas  ya que la clase TextMorph no las detecta a la hora de editar el texto.
"
Class {
	#name : #InputText,
	#superclass : #TextMorph,
	#instVars : [
		'keyboardTeclas'
	],
	#category : #TPOFinalVista
}

{ #category : #'event handling' }
InputText >> handlesKeyDown: anEvent [

keyboardTeclas detect:[:n|n = (anEvent keyValue)] ifFound: [self handleKeystroke: anEvent].

^true
]

{ #category : #initialization }
InputText >> initialize [ 
super initialize.
keyboardTeclas := #(31 30 28 29 8 127 1 4 11 12)

]
