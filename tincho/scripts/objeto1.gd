extends Area2D

func _on_body_entered(body):
	print(body.name)
	if body.name == "CharacterBody2D":
		print("CUERPO DETECTADO############")
		body.get_node("notif").visible = true


func _on_body_exited(body):
	print(body.name)
	if body.name == "CharacterBody2D":
		print("CUERPO SALIDO############")
		body.get_node("notif").visible = false
