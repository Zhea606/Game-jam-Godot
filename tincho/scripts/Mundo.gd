extends Node2D

@onready var enemigo = $Enemigo
@onready var spawn_player = $spawn_player

# Precargar escenas a instanciar
var player_scene = preload("res://scenes/player.tscn")
var camera_scene = preload("res://scenes/camera.tscn")
var player
var camera

@onready var lista_objetos: Dictionary
# Called when the node enters the scene tree for the first time.
func _ready():
	lista_objetos = {
		"Pocion de la suerte": Item.new("res://assets/propio/potion.png",Vector2(1,1),$spawn_objeto.position,"Pocion de la suerte","Esta es la pocion de la suerte."),
		"Huevo de la suerte": Item.new("res://assets/items/09.png",Vector2(1,1),$spawn_objeto2.position,"Huevo de la suerte","Re que era todo de la suerte xd.")
	}
	instantiate_objects()
	instantiate_player()
	
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

func instantiate_objects() -> void:
	for obj in lista_objetos:
		add_child(lista_objetos[obj])
