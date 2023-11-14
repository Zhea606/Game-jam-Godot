extends Node2D

@onready var camara = $CharacterBody2D/Camera2D
@onready var enemigo = $Enemigo
@onready var spawn_player = $spawn_player

var player_scene = preload("res://scenes/player.tscn")
var camera_scene = preload("res://scenes/camera.tscn")
var object_scene = preload("res://scenes/objeto1.tscn")
var player
var camera
# Called when the node enters the scene tree for the first time.
func _ready():
	instantiate_player()
	set_objects()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func instantiate_player():
	player = player_scene.instantiate()
	player.position = spawn_player.position
	add_child(player)
	instantiate_camera()

func instantiate_camera():
	camera = camera_scene.instantiate()
	camera.limit_left = -30
	camera.limit_bottom = 26
	camera.limit_right = 613
	player.add_child(camera)

func set_objects():
	var objeto1 = object_scene.instantiate()
	objeto1.position = $spawn_objeto.position
	add_child(objeto1)
