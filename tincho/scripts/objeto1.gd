extends Area2D

var dialogo_item_scene = preload("res://scenes/dialogo_item.tscn")

var path_image = ""

var nombre = ""
var descripcion = ""

# Variable de control para verificar si el personaje esta dentro del area
var char_in_area = false
var interact = false

@onready var sprite = $Sprite2D

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
		show_item()
		interact = true
	# Verificar cuando el jugador presiona enter despues de interactuar
	# con el objeto.
	# DE MOMENTO NO FUNCIONA COMO SE ESPERA
	if interact and Input.is_action_just_pressed("ui_accept"):
		get_tree().call_group("player","resume_player")
		get_parent().get_parent().get_node("cRelieve2").visible = false
		# Borrar objeto
		queue_free()
		
func _on_ready():
	sprite.texture = load(path_image)
	
func show_item():
	# Llamar a funcion del grupo player para detener al jugador
	get_tree().call_group("player","stop_player")
	
	sprite.visible = false
	
	get_parent().get_parent().get_node("cRelieve2").visible = true
	
	var dialogo_item = dialogo_item_scene.instantiate()
	
	add_child(dialogo_item)
	dialogo_item.titulo.text = nombre
	dialogo_item.descripcion.text = descripcion
	dialogo_item.set_image(path_image)
	dialogo_item.mostrar_texto()
