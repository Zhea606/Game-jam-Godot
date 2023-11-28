extends Node2D

@onready var player_scene = preload("res://scenes/player.tscn")
@onready var camera_scene = preload("res://scenes/camera.tscn")
@onready var player
@onready var camera

# Called when the node enters the scene tree for the first time.
func _ready():
	var reloj_puzzle = PuzzleObject.new("res://scenes/reloj.tscn","res://assets/puzzles/reloj-pendulo-sin-agujas.png",Vector2(0.13,0.13))
	add_child(reloj_puzzle)
	reloj_puzzle.position = $reloj.position
	instantiate_player()

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
	


func _on_comoda_area_body_entered(body):
	pass # Replace with function body.
