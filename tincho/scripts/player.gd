extends CharacterBody2D

const moveSpeed = 5
const maxSpeed = 50

const up = Vector2(0,-1)
const gravity = 15

@onready var sprite = $Sprite2D
@onready var spriteWalking = $SpriteWalk
@onready var animationPlayer = $AnimationPlayer
@onready var light = $PointLight2D
@onready var notif = $notif

var is_paused = false

func _physics_process(_delta):
	velocity.y += gravity
	var friction = false

	if Input.is_action_pressed("right_move") and !is_paused:
		sprite.visible = false
		spriteWalking.visible = true
		sprite.flip_h = false
		spriteWalking.flip_h = false
		animationPlayer.play("Walk")
		velocity.x = min(velocity.x + moveSpeed, maxSpeed)
		light.rotation_degrees = 0
	elif Input.is_action_pressed("left_move") and !is_paused:
		sprite.visible = false
		spriteWalking.visible = true
		sprite.flip_h = true
		spriteWalking.flip_h = true
		animationPlayer.play("Walk")
		velocity.x = max(velocity.x - moveSpeed, -maxSpeed)
		light.rotation_degrees = 180
	elif Input.is_action_just_pressed("switch_light") and !is_paused:
		if not light.enabled:
			light.enabled = true
		else:
			light.enabled = false
	else:
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
	
func stop_player():
	print("Jugador Pausado")
	is_paused = true
	
func resume_player():
	print("Jugador Renaudado")
	is_paused = false
