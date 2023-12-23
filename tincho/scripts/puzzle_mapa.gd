extends Control

@onready var pin = $CanvasLayer/Pin

var solved = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_texture_button_pressed() -> void:
	pin.position = get_viewport().get_mouse_position()

func _on_solucion_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if not solved:
		GLOBAL.puzzle_2454 = true
		solved = true

func _on_solucion_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if solved:
		GLOBAL.puzzle_2454 = false
		solved = false
