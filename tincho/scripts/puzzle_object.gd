extends InteractiveObject

class_name PuzzleObject

var scene

@onready var solved: bool

func _init(scene_path,image_path,escala):
	self.scene_path = scene_path
	self.image_path = image_path
	self.escala_sprite = escala

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("interact_object"):
		print("Presionando E")
		print(char_in_area)
	if char_in_area and Input.is_action_just_pressed("interact_object"):
		get_tree().call_group("player","stop_player")
		
		if not interact:
			scene = import_scene.instantiate()
			add_child(scene)
			interact = true
		else:
			scene.get_node("CanvasLayer").visible = true
	
	if interact and Input.is_action_just_pressed("ui_cancel"):
		scene.get_node("CanvasLayer").visible = false
		get_tree().call_group("player","resume_player")

