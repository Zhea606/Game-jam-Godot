extends Control

@onready var martillo = $CanvasLayer/CanvasGroup/martillo
@onready var carta = $CanvasLayer/CanvasGroup/carta
@onready var lapiz = $CanvasLayer/CanvasGroup/lapiz
@onready var disco = $CanvasLayer/CanvasGroup/disco
@onready var tijera = $CanvasLayer/CanvasGroup/tijera
@onready var papel = $CanvasLayer/CanvasGroup/papel

@onready var fondo = $CanvasLayer/fondo
@onready var imagen = $CanvasLayer/fondo/imagen

@onready var texto = $CanvasLayer/fondo/texto_diario

func _ready() -> void:
	var lista_objetos = [martillo,carta,lapiz,disco,tijera]
	
	for obj in lista_objetos:
		obj.pressed.connect(show_object.bind(obj))
	
	papel.pressed.connect(show_diary)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		fondo.visible = false
		texto.visible = false

func show_object(objeto) -> void:
	fondo.visible = true
	imagen.texture = objeto.texture_normal

func show_diary():
	imagen.texture = papel.texture_normal
	fondo.visible = true
	texto.visible = true

func _on_salir_pressed() -> void:
	fondo.visible = false
	texto.visible = false
