extends Area2D

@onready var reloj_scene = preload("res://scenes/reloj.tscn")

@onready var char_in_area = false
@onready var interact = false

@onready var reloj
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if char_in_area and Input.is_action_just_pressed("interact_object"):
		get_tree().call_group("player","stop_player")
		
		if not interact:
			reloj = reloj_scene.instantiate()
			add_child(reloj)
			interact = true
		else:
			reloj.get_node("CanvasLayer").visible = true
	
	if interact and Input.is_action_just_pressed("ui_cancel"):
		reloj.get_node("CanvasLayer").visible = false
		get_tree().call_group("player","resume_player")

func _on_body_entered(body):
	if body.is_in_group("player"):
		char_in_area = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		char_in_area = false

#func _unhandled_input(event: InputEvent) -> void:
	
