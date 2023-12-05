extends InteractiveObject

class_name PuzzleObject

var scene

func _init(scene_path,image_path,escala,posicion):
	self.scene_path = scene_path
	self.image_path = image_path
	self.escala_sprite = escala
	self.posicion = posicion

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Al presionar 'E' y si el personaje se encuentra en el area del objeto
	if char_in_area and Input.is_action_just_pressed("interact_object"):
		# Detener el movimiento del personaje cuando interactua con el puzzle
		get_tree().call_group("player","stop_player")
		
		# Si es la primera vez que interactua, instanciar la escena del puzzle
		# sino, solo hacer visible el puzzle
		if not interact:
			instantiate_scene()
			interact = true
		else:
			scene.get_node("CanvasLayer").visible = true
	
	# Al darle a ESC ocultar el puzzle y resumir el movimiento del pj
	if interact and Input.is_action_just_pressed("ui_cancel"):
		# Ocultar resolucion de puzzle una vez resuelto y salido del puzzle
		# A discutir
		#scene.get_node("CanvasLayer/Solved").visible = false
		
		# Ocultar Puzzle
		scene.get_node("CanvasLayer").visible = false
		
		# Resumir movimiento player
		get_tree().call_group("player","resume_player")
		
func instantiate_scene():
	scene = import_scene.instantiate()
	add_child(scene)
