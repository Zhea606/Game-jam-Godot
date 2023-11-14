extends Area2D

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.get_node("camera_player").add_trauma()
		body.queue_free()
		get_parent().instantiate_player()
