extends CharacterBody2D

const moveSpeed = 5
const maxSpeed = 50

const up = Vector2(0,-1)
const gravity = 15

# Sprite del personaje parado
@onready var sprite = $Sprite2D
# Sprite del personaje en movimiento
@onready var spriteWalking = $SpriteWalk
@onready var animationPlayer = $AnimationPlayer
@onready var light = $PointLight2D
# Notificacion de interaccion con objeto
@onready var notif = $notif

#Crear variable bool para pausar el personaje cuando sea necesario
var is_paused = false

func _physics_process(_delta):
	velocity.y += gravity
	var friction = false

	if Input.is_action_pressed("right_move") and !is_paused:
		# Ocultar sprite de personaje parado cuando se presiona tecla de movimiento
		sprite.visible = false
		# Mostrar sprite de personaje en movimiento
		spriteWalking.visible = true
		
		# No girar personaje cuando se va hacia la derecha
		sprite.flip_h = false
		spriteWalking.flip_h = false
		
		# Reproducir animacion de caminar
		animationPlayer.play("Walk")
		
		velocity.x = min(velocity.x + moveSpeed, maxSpeed)
		
		# No rotar la luz de la linterna cuando se va hacia la derecha
		light.rotation_degrees = 0
	elif Input.is_action_pressed("left_move") and !is_paused:
		sprite.visible = false
		spriteWalking.visible = true
		
		# Girar sprite de personaje cuando se va hacia la izquierda
		sprite.flip_h = true
		spriteWalking.flip_h = true
		
		# Reproducir animacion de caminar
		animationPlayer.play("Walk")
		
		velocity.x = max(velocity.x - moveSpeed, -maxSpeed)
		
		# Rotar luz de linterna cuando se va hacia la izquierda
		light.rotation_degrees = 180
	# Verificar si la accion switch light es accionada.
	elif Input.is_action_just_pressed("switch_light") and !is_paused:
		# Si la luz no es visible, habilitarla.
		# Caso contrario deshabilitarla
		if not light.enabled:
			light.enabled = true
		else:
			light.enabled = false
	else:
		# Si el jugador no realiza ningun movimiento utilizar sprite normal
		# y reproducir animacion del personaje parado
		sprite.visible = true
		spriteWalking.visible = false
		animationPlayer.play("Idle")
		friction = true

	if is_on_floor():
			
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.5)
	else:
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.01)

	move_and_slide()

# Funcion de control para pausar el personaje cuando sea necesario
func stop_player():
	print("Jugador Pausado")
	is_paused = true

# Funcion de control para renaudar el personaje luego de ser pausado
func resume_player():
	print("Jugador Renaudado")
	is_paused = false
