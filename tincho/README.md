# Métodos trabajados

* [Movimiento del jugador](#movimiento-del-jugador)
  - [Movimiento horizontal jugador](#movimiento-horizontal-del-jugador)
  - [Cambio de sprite cuando el jugador se mueve](#cambio-de-sprite-cuando-el-jugador-se-mueve)
  - [Animación de sprite](#animación-de-sprite)
* [Cámara](#cámara)
  - [Crear cámara que sigue al jugador](#crear-cámara-que-sigue-al-jugador)
  - [Límites de cámara](*límites-de-cámara)
* [Luz 2D](#luz-2d)
  - [Luz del personaje o modo linterna](*luz-del-personaje-o-modo-linterna)
  - [Interruptor de luz con tecla](*interruptor-de-luz-con-tecla)
  - [Rotación de luz](#rotación-de-luz)
  - [Luz con relieve](#luz-con-relieve)
  - [Sombras](#sombras)
* [Interacción con objetos](#interacción-con-objetos)
  - [Notificación de interacción con objeto](#notificación-de-interacción-con-objeto)



## Movimiento del jugador
### Movimiento horizontal del jugador
```
extends CharacterBody2D

const moveSpeed = 5
const maxSpeed = 50

const up = Vector2(0,-1)
const gravity = 15

@onready var sprite = $Sprite2D

func _physics_process(_delta):
	velocity.y += gravity
	var friction = false

	if Input.is_action_pressed("ui_right"):
		sprite.flip_h = false
		velocity.x = min(velocity.x + moveSpeed, maxSpeed)
	elif Input.is_action_pressed("ui_left"):
		velocity.x = max(velocity.x - moveSpeed, -maxSpeed)
	else:
		friction = true

	if is_on_floor():
			
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.5)
	else:
		if friction:
			velocity.x = lerp(velocity.x, 0.0, 0.01)

	move_and_slide()
```

### Cambio de sprite cuando el jugador se mueve

### Animación de sprite

## Cámara

### Crear cámara que sigue al jugador

### Límites de cámara

## Luz 2D

### Luz del personaje o modo linterna

### Interruptor de luz con tecla

### Rotación de luz

### Luz con relieve

### Sombras

## Interacción con objetos

### Notificación de interacción con objeto
