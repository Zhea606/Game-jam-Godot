extends Node

var enemigoEscena = preload("res://enemigos.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Timer para crear enemigos
func _on_enemy_respawn_timeout():
	crearEnemigo()
	
func crearEnemigo():
	var enemigoCreado = enemigoEscena.instantiate()
	enemigoCreado.global_position = Vector2(randf_range(0,1200),randf_range(0,564))
	add_child(enemigoCreado)



