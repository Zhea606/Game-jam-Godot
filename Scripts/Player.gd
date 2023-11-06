extends CharacterBody2D

class_name Player

#permite obtener como shortcut, reduce código
@onready var movement : Movement = $"Movement" as Movement 

#almacena la informacion del input
var input_vector: Vector2

#inicializa el movimiento
func _ready():
	movement.setup(self) 

#obtiene el input del player
func _process(delta):
	input_vector.x = Input.get_axis("move_left", "move_right")
#	*********************************************************************falta el jump

#funcion que mueve el personaje
func _physics_process(delta):
	movement.move(input_vector.normalized())
