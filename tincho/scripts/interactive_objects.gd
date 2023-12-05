extends Area2D

# Asignar nombre de clase para hacerla publica
class_name InteractiveObject

# Asignar nodos de sprite y colision a variables
var sprite: Sprite2D
var collision: CollisionShape2D

# Posicion del objeto
var posicion: Vector2

# Variable para escalar el sprite
@export var escala_sprite: Vector2

# Definir rutas hacia escena e imagen del sprite
var scene_path: String
var image_path: String

# Variable para cargar escena de dialogo o puzzle
var import_scene: PackedScene

# Booleanos para controlar la interaccion
@onready var char_in_area = false
@onready var interact = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Importar escena e imagen
	import_scene = load(scene_path)
	
	# Setear posicion
	position = posicion
	# Setear sprite
	set_sprite()
	# Setear colision del sprite
	set_colission()
	
	# Cuando se utiliza herencia de clases se debe realizar
	# la conexion de señales por codigo
	# Ver documentacion oficial de señales
	body_entered.connect(_on_object_entered)
	body_exited.connect(_on_object_exited)

func set_colission() -> void:
	# Crear un nuevo CollisionShape2D y agregarlo a la escena
	collision = CollisionShape2D.new()
	add_child(collision)
	
	# Obtener tamaño de imagen cargada
	var width = sprite.texture.get_width()
	var height = sprite.texture.get_height()
	
	# Crear un RectangleShape con las dimensiones obtenidas
	var shape = RectangleShape2D.new()
	shape.set_size(Vector2(width,height))
	
	# Asignar el shape creado al CollisionShape2D
	collision.set_shape(shape)
	# Escalar a la misma proporcion que al sprite
	collision.scale = escala_sprite

# Setear sprite de la imagen del objeto
func set_sprite() -> void:
	# Crear un nuevo Sprite2D y agregarlo a la escena
	sprite = Sprite2D.new()
	add_child(sprite)
	
	# Cargar imagen en la textura del sprite
	sprite.set_texture(load(image_path))
	# Escalar Sprite
	sprite.scale = escala_sprite

func _on_object_entered(body):
	# Verificar si el cuerpo que ingresa pertenece al grupo "player"
	if body.is_in_group("player"):
		# Mostrar notificacion de interaccion
		body.get_node("notif").visible = true
		# Validar personaje encima del objeto
		char_in_area = true

func _on_object_exited(body):
	# Verificar si el cuerpo que sale pertenece al grupo "player"
	if body.is_in_group("player"):
		# Ocultar notificacion de interaccion
		body.get_node("notif").visible = false
		# Validar personaje no se encuentra encima del objeto
		char_in_area = false
