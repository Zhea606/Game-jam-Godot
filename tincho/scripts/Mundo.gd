extends Node2D

@onready var camara = $CharacterBody2D/Camera2D
@onready var enemigo = $Enemigo
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_enemigo_body_entered(body):
	if body.name == "CharacterBody2D":
		camara.add_trauma()
