extends Node2D

# Precargar escena de dialogo
@onready var dialogo_tuto_scene = preload("res://scenes/dialogo_tuto.tscn")
# Tomar character body de la escena y referenciarlo en variable
@onready var player = $CharacterBody2D

var dialogo
var dialogo_exist = false

# Called when the node enters the scene tree for the first time.
func _ready():
	show_dialogue("Para moverte utiliza WASD")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("exit_dialogue") and dialogo_exist:
		player.resume_player()
		dialogo_exist = false
		dialogo.queue_free()
		

func show_dialogue(text: String):
	dialogo = dialogo_tuto_scene.instantiate()
	add_child(dialogo)
	dialogo.descripcion.text = text
	
	player.stop_player()
	dialogo.mostrar_texto()
	dialogo_exist = true



func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		show_dialogue("Para interactuar con los objetos utiliza la letra E")
	
