extends Node2D

@onready var enemigo = $Enemigo
@onready var spawn_player = $spawn_player

# Precargar escenas a instanciar
var player_scene = preload("res://scenes/player.tscn")
var camera_scene = preload("res://scenes/camera.tscn")
var object_scene = preload("res://scenes/objeto1.tscn")
var player
var camera
# Called when the node enters the scene tree for the first time.
func _ready():
	instantiate_player()
	set_object($spawn_objeto.position,"Pocion de la suerte","Esta es la pocion de la suerte.","res://assets/propio/potion.png")
	set_object($spawn_objeto2.position,"Huevo de la suerte","Re que era todo de la suerte xd.","res://assets/items/09.png")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func instantiate_player():
	# Instanciar escena del personaje
	player = player_scene.instantiate()
	# Definir su posicion a partir de otro sprite creado en la escena
	player.position = spawn_player.position
	# Agregarlo a la escena principal como hijo
	add_child(player)
	# Instanciar la camara del personaje
	instantiate_camera()

func instantiate_camera():
	# Instanciar escena de la camara
	camera = camera_scene.instantiate()
	# Definir sus limites
	camera.limit_left = -30
	camera.limit_bottom = 26
	camera.limit_right = 613
	# Agregar la camara como hija del personaje
	player.add_child(camera)

func set_object(position_obj: Vector2,name_obj: String,description: String,image_path: String):
	var objeto = object_scene.instantiate()
	objeto.position = position_obj
	objeto.get_child(0).nombre = name_obj
	objeto.get_child(0).descripcion = description
	objeto.get_child(0).path_image = image_path
	add_child(objeto)
