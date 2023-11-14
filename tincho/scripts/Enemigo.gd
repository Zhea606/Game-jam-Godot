extends Area2D

# Funcion para cuando un cuerpo ingresa al Area2D
func _on_body_entered(body):
	# Verificar si el cuerpo que ingresa pertenece al grupo "player"
	if body.is_in_group("player"):
		# Obtener la camara del personaje y llamar a la funcion add_trauma()
		body.get_node("camera_player").add_trauma()
		# Eliminar personaje e instanciar nuevamente llamando la funcion
		# de la escena principal
		body.queue_free()
		get_parent().instantiate_player()
