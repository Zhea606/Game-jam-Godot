extends CharacterBody2D

var jugador : Jugador
var velocidadEnemigo = 200
var direction = Vector2(0.0,0.0)
@onready var spriteEnemigo = $Sprite2D
func _ready():
	jugador = get_tree().get_first_node_in_group("Jugador")
func _physics_process(delta):
	var direction = jugador.global_position-global_position
	spriteEnemigo.flip_h = direction > Vector2(0.0,0.0)
	if jugador:
		velocity = Vector2(jugador.global_position-global_position).normalized() * velocidadEnemigo
		move_and_slide()
		
func morir():
	queue_free()
		

