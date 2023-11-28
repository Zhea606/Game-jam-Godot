extends CharacterBody2D

const moveSpeed = 5
const maxSpeed = 50

const up = Vector2(0,-1)
const gravity = 15

@onready var sprite = $Sprite2D
@onready var spriteWalking = $SpriteWalk
@onready var spriteRunning = $SpriteRun
@onready var animationPlayer = $AnimationPlayer
@onready var light = $PointLight2D
@onready var notif = $notif

#usado para pausar el movimiento del personaje al aparecer un diálogo tutorial
var is_paused = false
var friction

func _physics_process(_delta):
	velocity.y += gravity
	friction = false
	if not is_paused:
		if Input.is_action_pressed("right_move"):
			sprite.visible = false
			spriteWalking.visible = true
			spriteRunning.visible = false
			sprite.flip_h = false
			spriteWalking.flip_h = false
			spriteRunning.flip_h = false
#	        # //para sprint
			if Input.is_action_pressed("sprint") :
				velocity.x = min(velocity.x + moveSpeed, maxSpeed) * 3
				sprite.visible = false
				spriteWalking.visible = false
				spriteRunning.visible = true
				sprite.flip_h = false
				spriteWalking.flip_h = false
				animationPlayer.play("Run")
			else :
				animationPlayer.play("Walk")
				velocity.x = min(velocity.x + moveSpeed, maxSpeed)			
			light.rotation_degrees = 0
		elif Input.is_action_pressed("left_move"):
			sprite.visible = false
			spriteWalking.visible = true
			sprite.flip_h = true
			spriteWalking.flip_h = true
			# //para sprint
			if Input.is_action_pressed("sprint") :
				velocity.x = max(velocity.x - moveSpeed, -maxSpeed) * 3
				sprite.visible = false
				spriteWalking.visible = false
				spriteRunning.visible = true
				sprite.flip_h = false
				spriteWalking.flip_h = false
				spriteRunning.flip_h= true
				animationPlayer.play("Run")
			else :
				animationPlayer.play("Walk")
				velocity.x = max(velocity.x - moveSpeed, -maxSpeed)
			light.rotation_degrees = 180
		elif Input.is_action_just_pressed("switch_light"):
			if not light.enabled:
				light.enabled = true
			else:
				light.enabled = false
		else:
			sprite.visible = true
			spriteWalking.visible = false
			spriteRunning.visible = false			
			animationPlayer.play("Idle")
			friction = true

		if is_on_floor():
				
			if friction:
				velocity.x = lerp(velocity.x, 0.0, 0.5)
		else:
			if friction:
				velocity.x = lerp(velocity.x, 0.0, 0.01)

		move_and_slide()
	
	
	
#func _draw():
#	notif.visible = true
#	pass


#
#func stop_player() -> void:
#	is_paused = true
#	animationPlayer.play("Idle")
#	if spriteWalking.visible:
#		sprite.visible = true
#		spriteWalking.visible = false
#		spriteRunning.visible = false
#
#func resume_player() -> void:
#	is_paused = false
