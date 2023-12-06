extends Node2D

@onready var itemPuzzle = $ItemPuzzle


#Cambiamos de escena
func _on_button_pressed():
	get_tree().change_scene_to_file("res://juego.tscn")



func _on_madera_1_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("clickPuzzle"):
		print("prueba madera1")


func _on_madera_2_input_event(viewport, event, shape_idx):
		if Input.is_action_just_pressed("clickPuzzle"):
			print("prueba madera2")


func _on_madera_3_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("clickPuzzle"):
			print("prueba madera3")


func _on_madera_4_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("clickPuzzle"):
			print("prueba madera4")


func _on_madera_5_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("clickPuzzle"):
			itemPuzzle.show()
			
			GLOBAL.puzzleResuelto = false
			print("prueba madera5")

#al mover el mouse de la madera, se esconde el objeto
func _on_madera_5_mouse_exited():
	itemPuzzle.hide()
