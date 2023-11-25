extends Node2D

@onready var dialogo_tuto_scene = preload("res://scenes/dialogo_tuto.tscn")
@onready var player = $CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var dialogo = dialogo_tuto_scene.instantiate()
	dialogo.descripcion = "Para moverte utiliza WASD"
	add_child(dialogo)
	
	
	dialogo.mostrar_texto()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
