extends Node2D

@onready var player_scene = preload("res://scenes/player.tscn")
@onready var camera_scene = preload("res://scenes/camera.tscn")
@onready var player
@onready var camera

# Lista para instanciar objetos
@onready var lista_objetos: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	lista_objetos = {
		"puzzle_reloj": PuzzleObject.new("res://scenes/reloj.tscn","res://assets/puzzles/reloj-pendulo-sin-agujas.png",Vector2(0.13,0.13),$reloj.position),
		"comoda": PuzzleObject.new("res://scenes/cajon.tscn","res://assets/propio/comoda.png",Vector2(0.9,0.75),$comoda.position),
		"puzzle_mapa": PuzzleObject.new("res://scenes/puzzle_mapa.tscn","res://assets/puzzles/mapamundi-pixel.png",Vector2(0.02,0.02),$mapamundi.position),
		"mesita": PuzzleObject.new("res://scenes/mesita.tscn","res://assets/objects/mesa.png",Vector2(0.015,0.015),$mesita.position)
		}
	instantiate_objects()
	instantiate_player()
	var puzzles = PuzzleData.new("res://savedata/puzzles_data.json")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func instantiate_player():
	player = player_scene.instantiate()
	player.position = $spawn_player.position
	add_child(player)
	instantiate_camera()
	
func instantiate_camera():
	camera = camera_scene.instantiate()
	camera.limit_left = -80
	camera.limit_bottom = 20
	camera.limit_right = 478
	camera.zoom = Vector2(9,9)
	player.add_child(camera)
	
func instantiate_objects() -> void:
	for obj in lista_objetos:
		add_child(lista_objetos[obj])

func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
