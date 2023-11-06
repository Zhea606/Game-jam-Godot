# Métodos trabajados

* [Movimiento del jugador](#movimiento-del-jugador)
  - [Movimiento horizontal jugador](#movimiento-horizontal-del-jugador)
  - [Cambio de sprite cuando el jugador se mueve](#cambio-de-sprite-cuando-el-jugador-se-mueve)
  - [Animación de sprite](#animación-de-sprite)
* [Cámara](#cámara)
  - [Crear cámara que sigue al jugador](#crear-cámara-que-sigue-al-jugador)
  - [Límites de cámara](#límites-de-cámara)
* [Luz 2D](#luz-2d)
  - [Luz del personaje o modo linterna](#luz-del-personaje-o-modo-linterna)
  - [Interruptor de luz con tecla](#interruptor-de-luz-con-tecla)
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
		sprite.flip_h = true
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
- Para hacer el cambio hay que tener dos nodos (sprite2D) creados con las distintas imágenes.

Sprite2D

![Imágen de Sprite2D](https://github.com/Zhea606/Game-jam-Godot/blob/4b540492c321d15a66206ba76ccfb4ecfc3e0589/tincho/assets/character/Character%20Idle%2048x48.png)

SpriteWalk

![Imágen de SpriteWalk](https://github.com/Zhea606/Game-jam-Godot/blob/4b540492c321d15a66206ba76ccfb4ecfc3e0589/tincho/assets/character/PlayerWalk%2048x48.png)

- Referenciar ambos sprites
```
@onready var sprite = $Sprite2D
@onready var spriteWalking = $SpriteWalk
```
- Cambiar visibilidad de sprite cuando el jugador presiona para caminar y cuando no lo hace. Con la propiedad *visible* (bool).
```
if Input.is_action_pressed("ui_right"):
	sprite.visible = false
	spriteWalking.visible = true
	sprite.flip_h = false
	spriteWalking.flip_h = false
	...
elif Input.is_action_pressed("ui_left"):
	sprite.visible = false
	spriteWalking.visible = true
	sprite.flip_h = true
	spriteWalking.flip_h = true
	...
else:
	sprite.visible = true
	spriteWalking.visible = false
	...
```

### Animación de sprite
- Ref: [Tuto youtube](https://youtu.be/NeUS3Ytjty4?si=dIS_vFYNJOTbO4Ea)

Código:
```
@onready var animationPlayer = $AnimationPlayer

func _physics_process(_delta):
	...
	if Input.is_action_pressed("ui_right"):
		...
		animationPlayer.play("Walk")
		...
	elif Input.is_action_pressed("ui_left"):
		...
		animationPlayer.play("Walk")
		...
	else:
		animationPlayer.play("Idle")
		...
	if is_on_floor():
		...
	move_and_slide()
```
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
