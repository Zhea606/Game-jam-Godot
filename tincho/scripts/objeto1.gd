extends Area2D

# Precargar la escena de dialogo
var dialogo = preload("res://dialogos/objects.dialogue")

# Variable de control para verificar si el personaje esta dentro del area
var char_in_area = false

# Funcion para cuando un cuerpo ingresa al Area2D
func _on_body_entered(body):
	# Verificar si el cuerpo que ingresa pertenece al grupo "player"
	if body.is_in_group("player"):
		# Mostrar la notificacion de interaccion con objeto
		body.get_node("notif").visible = true
		char_in_area = true
	
func _on_body_exited(body):
	# Cuando el cuerpo sale del Area, deshabilitar la notificacion
	# y cambiar la variable de control
	if body.is_in_group("player"):
		body.get_node("notif").visible = false
		char_in_area = false

# Metodo para verificar eventos input en Areas 2D
func _unhandled_input(event: InputEvent) -> void:
	# Verificar si el cuerpo esta dentro del Area2D y realiza la
	# accion interact_object (letra E)
	if char_in_area and Input.is_action_just_pressed("interact_object"):
		# Crear dialogo con DialogueManager
		DialogueManager.show_example_dialogue_balloon(dialogo,"start")
		# Llamar a funcion del grupo player para detener al jugador
		get_tree().call_group("player","stop_player")
	# Verificar cuando el jugador presiona enter despues de interactuar
	# con el objeto.
	# DE MOMENTO NO FUNCIONA COMO SE ESPERA
	if char_in_area and Input.is_action_just_pressed("ui_accept"):
		get_tree().call_group("player","resume_player")
		# Borrar objeto
		queue_free()
		
func _on_ready():
	pass # Replace with function body.
