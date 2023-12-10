extends Node2D


func _ready():
	DialogueManager.show_dialogue_balloon(load("res://main.dialogue"), "start")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
