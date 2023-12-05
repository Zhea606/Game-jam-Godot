extends Control

@onready var papel = $CanvasLayer/papel
@onready var pluma = $CanvasLayer/pluma

@onready var fondo = $CanvasLayer/Fondo
@onready var imagen = $CanvasLayer/Fondo/imagen
@onready var texto = $CanvasLayer/Fondo/texto_diario

@onready var salir = $CanvasLayer/Fondo/salir

var solved = false

func _ready() -> void:
	papel.pressed.connect(show_diary)
	salir.pressed.connect(_on_salir_pressed)
	pluma.pressed.connect(_on_pluma_pressed)

func show_diary():
	imagen.texture = papel.texture_normal
	fondo.visible = true
	texto.visible = true

func _on_salir_pressed():
	fondo.visible = false
	texto.visible = false
	
func _on_pluma_pressed():
	fondo.visible = true
	imagen.texture = pluma.texture_normal
