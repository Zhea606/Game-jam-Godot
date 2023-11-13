# Métodos trabajados

* [Movimiento del jugador](#movimiento-del-jugador)
  - [Movimiento horizontal jugador](#movimiento-horizontal-del-jugador)
  - [Cambio de sprite cuando el jugador se mueve](#cambio-de-sprite-cuando-el-jugador-se-mueve)
  - [Animación de sprite](#animación-de-sprite)
* [Cámara](#cámara)
  - [Crear cámara que sigue al jugador](#crear-cámara-que-sigue-al-jugador)
  - [Límites de cámara](#límites-de-cámara)
  - [Hacer temblar cámara](#hacer-temblar-cámara)
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

#### Cambio de sprite cuando el jugador se mueve
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
- Para crear una cámara 2D que siga al jugador sólo debemos crear un nodo "Camera2D" como hijo del personaje, ya sea en la escena principal o en la escena del personaje.

![Camera2D](https://sp-ao.shortpixel.ai/client/to_webp,q_glossy,ret_img,w_407/https://www.nightquestgames.com/wp-content/uploads/2023/04/godot-4-adding-camera-under-player-1.png)

Ref: [Documentación Oficial](https://docs.godotengine.org/es/4.x/classes/class_camera2d.html)

### Límites de cámara
- Los limites de la cámara son una propiedad del Nodo, se pueden configurar para que la cámara se detenga en ciertos puntos como los límites del mapa.

Ref: [[TUTORIAL] IndieLibre | Límites de cámara 2D | Godot 3](https://youtu.be/0IWIngMt06E?si=thYIVumCJD1_kB9L)

### Hacer temblar cámara

- Ref: [Godot 4 Camera Shake Tutorial](https://www.youtube.com/watch?v=LGt-jjVf-ZU)

Código:
```
extends Camera2D

@export var randomStrength: float = 10.0
@export var shakeFade: float = 5.0

var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0

@onready var old_offset = offset

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func add_trauma() -> void:
	shake_strength = randomStrength

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength,0,shakeFade * delta)
		
		offset = randomOffset()
	
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength),rng.randf_range(-shake_strength,shake_strength))
```

## Luz 2D

### Luz del personaje o modo linterna
#### Luz del personaje
- Ref: [Iluminación 2D en Godot Engine 4](https://youtu.be/S-Qch9kxdRg?si=rpEa6M-pUeg1mPji)
#### Modo linterna
- Ref: [Starlord's flashlight effect - Godot engine tutorial](https://www.youtube.com/watch?v=hefnwhE-ZZA)

### Interruptor de luz con tecla
- Ref: [Tutorial Godot engine 3D prender luz tipo linterna con spotlight](https://youtu.be/jCGwkTnCTjM?si=tK9nB0m3CDvv5q9P)

- Agregar entrada en Input Map (Project Settigns -> Input Map), en este caso "switch_light"

Código:
```
extends CharacterBody2D

@onready var light = $PointLight2D

func _physics_process(_delta):

	if Input.is_action_just_pressed("switch_light"):
			if not light.enabled:
				light.enabled = true
			else:
				light.enabled = false
```
### Rotación de luz
- Para rotar la luz cuando el personaje gira, hay que rotar 180° el nodo con la propiedad "Rotation"

Código:
```
extends CharacterBody2D

@onready var light = $PointLight2D

func _physics_process(_delta):

	if Input.is_action_pressed("ui_right"):
		light.rotation_degrees = 0
	elif Input.is_action_pressed("ui_left"):
		light.rotation_degrees = 180  # Si el jugador gira hacia la izquierda, girar la luz 180 grados.
```
### Luz con relieve
- Para crear un mejor efecto de la iluminación sobre el fondo, deberemos crear el normal map del mismo

Ref: [Blender Tutorial - How to Create Normal Maps in Gimp](https://www.youtube.com/watch?v=vxBRJrnXyto)

- Creamos en godot un sprite2D para el fondo y en Texture elegimos "New Canvas Texture"

![New Canvas Texture](https://docs.godotengine.org/en/stable/_images/2d_lights_and_shadows_create_canvastexture.webp)

- Editamos el Canvas Texture

Diffuse: La imágen de fondo

Normal Map: El normal map creado anteriormente 

Ref: [Documentación Oficial](https://docs.godotengine.org/en/stable/tutorials/2d/2d_lights_and_shadows.html#normal-and-specular-maps)
### Sombras

## Interacción con objetos

### Notificación de interacción con objeto
- Creamos un sprite en el personaje para colocar la imágen de la notificación.

Ejemplo:

![Notificación](https://github.com/Zhea606/Game-jam-Godot/blob/560bec4488ce812d2e2df955ee3b9b36c218826b/tincho/assets/propio/notif.png)

- En la escena donde queramos que aparezca la notificación creamos un Área 2D con el código para activarla cuando un cuerpo ingrese a la misma.
```
extends Area2D

func _on_body_entered(body):
	print(body.name)
	if body.name == "CharacterBody2D":
		body.get_node("notif").visible = true
	
# Cuando el personaje salga del area la notificacion debe desaparecer
func _on_body_exited(body):
	print(body.name)
	if body.name == "CharacterBody2D":
		body.get_node("notif").visible = false
```