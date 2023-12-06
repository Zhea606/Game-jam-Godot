
extends CharacterBody2D
class_name Jugador
var speed = 400
var direction = 0.0
var texto = ""
#@export_file('*.tscn') var cambiarEscena
const gravedad = 600
var proyectil = preload("res://proyectil.tscn")
var jugadorPuzzle = false
var autoLoadPuzzleResuelto = GLOBAL.puzzleResuelto
@onready var audioPuzzle = $"../AudioStreamPlayer2D"
@onready var sprite = $Sprite2D

func _physics_process(delta):
	#checkeamos que el jugador este parado en el puzzle y con ENTER cambiamos la escena
	if jugadorPuzzle and Input.is_action_just_pressed("activarPuzzle"):
			print("hola")
			get_tree().change_scene_to_file("res://puzzle_2023.tscn")
	#Movimiento del jugador
	var direction = Input.get_axis("ui_left","ui_right")
	var moverIzqDer = Input.get_axis("ui_left","ui_right")
	var moverArrAba = Input.get_axis("ui_up","ui_down")
	var moverAmbas = Vector2(moverIzqDer,moverArrAba)
	velocity= moverAmbas.normalized() * speed
	sprite.flip_h = direction < 0
	#gravedad
	velocity.y += gravedad
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
	#checkeamos estar parados sobre el puzzle
	if body.is_in_group("puzzle") and autoLoadPuzzleResuelto:		
		jugadorPuzzle = true
		texto = convert(jugadorPuzzle,1)
		print(texto)	
		audioPuzzle.play()
#señal para cambiar el estado del jugador encima del puzzle
func _on_detection_body_exited(body):
	if body.is_in_group("puzzle"):
		jugadorPuzzle = false
		texto = convert(jugadorPuzzle,1)
		print(texto)
