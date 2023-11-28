extends Control

@onready var minutes = $CanvasLayer/minute_arrow
@onready var hours = $CanvasLayer/hour_arrow

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_minute_button_pressed():
	minutes.rotation_degrees += 30
	if minutes.rotation_degrees >= 360:
		minutes.rotation_degrees = 0


func _on_hour_button_pressed():
	hours.rotation_degrees += 30
	if hours.rotation_degrees >= 360:
		hours.rotation_degrees = 0
