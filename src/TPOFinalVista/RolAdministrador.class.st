Class {
	#name : #RolAdministrador,
	#superclass : #Morph,
	#instVars : [
		'sistema',
		'crearBiblioteca',
		'verBiblioteca',
		'cambiarModalidadUsuario',
		'retroceder',
		'verUsuario',
		'modificarMaterial',
		'setDiasSuspensionImporte',
		'verUsuariosAtrasados',
		'pagarCuota',
		'agregarBibliotecaAdministrador'
	],
	#category : #TPOFinalVista
}

{ #category : #'as yet unclassified' }
RolAdministrador class >> crearConSistema:sistema [

|unMorph|
unMorph:=self new.
unMorph inicializarConSistema:sistema.
^unMorph.
]

{ #category : #'as yet unclassified' }
RolAdministrador >> botonRetroceder [ 
retroceder  :=SimpleButtonMorph new.
self addMorph:retroceder .
retroceder label:'Volver al menú principal'font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
retroceder bottomLeft:self bottomLeft -(-20@20).
retroceder target:[		
		self hide.
	   self owner cargarPantallaPrincipal .
		].
retroceder actionSelector:#value.
]

{ #category : #'as yet unclassified' }
RolAdministrador >> inicializarBotones [ 
	
crearBiblioteca target:[
		self hide.
		self owner mostrarAgregarBibliotecaAdministrador.		
	].
crearBiblioteca actionSelector:#value.
	
verBiblioteca target:[
	self hide.
"	self owner cargarVerBiblioteca:'admin'."
	self owner cargarSeleccionarVerBiblioteca.
	].
verBiblioteca actionSelector:#value.

cambiarModalidadUsuario  target:[
	self hide.
	self owner cargarCambiarModalidadUsuario.		
	].
cambiarModalidadUsuario  actionSelector:#value.

verUsuario target:[
		self hide.
		self owner cargarPantallaVerUsuario.
	].
verUsuario actionSelector:#value.

modificarMaterial target:[
	self hide.
	self owner cargarModificarMaterialBibliografico.
	].
modificarMaterial actionSelector:#value.

setDiasSuspensionImporte target:[
	self hide.
	self owner cargarSetDiasSuspensionImporte.
	].
setDiasSuspensionImporte actionSelector: #value.

verUsuariosAtrasados target:[
	self hide.
	self owner cargarUsuariosAtrasados	
	].
verUsuariosAtrasados actionSelector: #value.

pagarCuota target:[
	self hide.
	self owner cargarPagarCuota.
	].
pagarCuota actionSelector:#value.
]

{ #category : #initialization }
RolAdministrador >> inicializarConSistema:sistema2 [
|fuente admin|
self width:1000.
self height:620.

fuente:=(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .
sistema :=sistema2.

crearBiblioteca :=SimpleButtonMorph new.
self addMorph:crearBiblioteca .
crearBiblioteca label:'Crear Biblioteca'font:fuente.

verBiblioteca :=SimpleButtonMorph new.
self addMorph:verBiblioteca .
verBiblioteca label:'Ver Biblioteca' font:fuente.

cambiarModalidadUsuario  :=SimpleButtonMorph new.
self addMorph:cambiarModalidadUsuario .
cambiarModalidadUsuario label:'Cambiar modalidad de usuario'font:fuente.
"-----"
crearBiblioteca width:cambiarModalidadUsuario width.
crearBiblioteca  center:self center -(0@150).
verBiblioteca width:cambiarModalidadUsuario width.
verBiblioteca topLeft:crearBiblioteca bottomLeft +(0@20).
cambiarModalidadUsuario  width:cambiarModalidadUsuario width. 
cambiarModalidadUsuario topLeft:verBiblioteca bottomLeft+(0@20).

verUsuario := SimpleButtonMorph new.
verUsuario label:'Ver Usuario' font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20) .
self addMorph:verUsuario.
verUsuario width:cambiarModalidadUsuario width.
verUsuario topLeft:cambiarModalidadUsuario bottomLeft +(0@20).

modificarMaterial :=SimpleButtonMorph new.
modificarMaterial label:'Modificar material bibliográfico'font:fuente.
self addMorph:modificarMaterial.
modificarMaterial topLeft:verUsuario bottomLeft+(0@20).

admin:= 'Administrador' asStringMorph .
admin font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 40). 
self addMorph:admin.
admin center:self center.
admin top:self top +20.

setDiasSuspensionImporte  :=SimpleButtonMorph new.
setDiasSuspensionImporte label:'Modificar suspensión e importe'font:fuente.
self addMorph:setDiasSuspensionImporte.
setDiasSuspensionImporte width:cambiarModalidadUsuario width.
setDiasSuspensionImporte topLeft:modificarMaterial bottomLeft+(0@20).


verUsuariosAtrasados :=SimpleButtonMorph new.
verUsuariosAtrasados label:'Ver usuarios atrasados' font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
self addMorph:verUsuariosAtrasados.
verUsuariosAtrasados width: cambiarModalidadUsuario width.
verUsuariosAtrasados center:self center.
verUsuariosAtrasados top:setDiasSuspensionImporte  bottom+20.

pagarCuota:=SimpleButtonMorph new.
self addMorph:pagarCuota.
pagarCuota label:'Aceptar pago de Usuario Plus' font:(StrikeFont familyName: 'Bitmap DejaVu Sans' size: 20).
pagarCuota width: cambiarModalidadUsuario width.
pagarCuota center:self center.
pagarCuota top: verUsuariosAtrasados bottom+20.

self botonRetroceder.
self inicializarBotones.
]

{ #category : #'as yet unclassified' }
RolAdministrador >> recargar [ 
self hide.
self inicializarConSistema: sistema.
]
