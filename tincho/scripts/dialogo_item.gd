extends Control

@onready var image_item = $CanvasLayer/image_item
@onready var animation = $CanvasLayer/animation_text
@onready var titulo = $CanvasLayer/titulo
@onready var descripcion = $CanvasLayer/descripcion


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func mostrar_texto():
	animation.play("show")

func set_image(path: String):
	image_item.texture = load(path)
