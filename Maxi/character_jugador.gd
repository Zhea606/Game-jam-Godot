
extends CharacterBody2D
class_name Jugador
var speed = 400
var direction = 0.0
var proyectil = preload("res://proyectil.tscn")

@onready var sprite = $Sprite2D

func _process(delta):
	#Movimiento del jugador
	var direction = Input.get_axis("ui_left","ui_right")
	var moverIzqDer = Input.get_axis("ui_left","ui_right")
	var moverArrAba = Input.get_axis("ui_up","ui_down")
	var moverAmbas = Vector2(moverIzqDer,moverArrAba)
	velocity= moverAmbas.normalized() * speed
	sprite.flip_h = direction < 0
	move_and_slide()
	
	#creamos los proyectiles y definimos el movimiento
	if Input.is_action_just_pressed("disparar"):
		print("disparo")
		var fuego = proyectil.instantiate()
		fuego.direccion = (get_global_mouse_position() - global_position).normalized()
		fuego.global_position = global_position
		get_parent().add_child(fuego)


#Señal para detectar a los enemigos y que mueran
func _on_detection_body_entered(body):
	if body.is_in_group("Enemigo"):
		body.morir()
