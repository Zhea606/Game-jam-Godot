extends Area2D

var direccion : Vector2
var velocidad := 500

func _process(delta):
	global_position.direction_to(direccion)
	global_position  += velocidad * direccion * delta
