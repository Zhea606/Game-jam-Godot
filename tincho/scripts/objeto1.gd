extends Area2D

# Precargar la escena de dialogo
#@export var dialogo_scene : PackedScene
var dialogo = preload("res://dialogos/objects.dialogue")
var char_in_area = false
var player

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.get_node("notif").visible = true
		char_in_area = true
	
func _on_body_exited(body):
	if body.is_in_group("player"):
		body.get_node("notif").visible = false
		char_in_area = false

# Metodo para verificar eventos input en Areas 2D
func _unhandled_input(event: InputEvent) -> void:
	if char_in_area and Input.is_action_just_pressed("interact_object"):
		DialogueManager.show_example_dialogue_balloon(dialogo,"start")
		get_tree().call_group("player","stop_player")
	if char_in_area and Input.is_action_just_pressed("ui_accept"):
		get_tree().call_group("player","resume_player")
		queue_free()
		
func _on_ready():
	pass # Replace with function body.
