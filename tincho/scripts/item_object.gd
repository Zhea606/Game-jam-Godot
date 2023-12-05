extends InteractiveObject

class_name Item

var nombre: String
var descripcion: String

func _init(image_path,escala,posicion,nombre,descripcion):
	self.scene_path = "res://scenes/dialogo_item.tscn"
	self.image_path = image_path
	self.escala_sprite = escala
	self.posicion = posicion
	self.nombre = nombre
	self.descripcion = descripcion

func _process(delta: float) -> void:
	# Verificar si el cuerpo esta dentro del Area2D y realiza la
	# accion interact_object (letra E)
	if char_in_area and Input.is_action_just_pressed("interact_object"):
		show_item()
		interact = true
	# Verificar cuando el jugador presiona escape despues de interactuar
	# con el objeto.
	if interact and Input.is_action_just_pressed("ui_cancel"):
		get_tree().call_group("player","resume_player")
		# Borrar objeto
		queue_free()

func show_item() -> void:
	# Llamar a funcion del grupo player para detener al jugador
	get_tree().call_group("player","stop_player")
	
	sprite.visible = false
	
	var dialogo_item = import_scene.instantiate()
	
	add_child(dialogo_item)
	dialogo_item.titulo.text = nombre
	dialogo_item.descripcion.text = descripcion
	dialogo_item.set_image(image_path)
	dialogo_item.mostrar_texto()
