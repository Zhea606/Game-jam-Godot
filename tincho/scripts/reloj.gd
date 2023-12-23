extends Control

# Tomar agujas de minutos y hora
@onready var minutes = $CanvasLayer/minute_arrow
@onready var hours = $CanvasLayer/hour_arrow

var solved = false

@onready var unlock_sound = $unlock

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Verificar si la rotacion coincide con la hora deseada
	if !solved and int(minutes.rotation_degrees) == 180 and int(hours.rotation_degrees) == 90:
		#print("Puzzle resuelto")
		unlock_sound.play()
		$CanvasLayer/Solved.visible = true
		solved = true
		# Guardar estado de puzzle
		GLOBAL.puzzle_1954 = true
	#print(int(hours.rotation_degrees))

# En caso de presionar aguja de minutos, rotar 30 grados
func _on_minute_button_pressed():
	minutes.rotation_degrees += 30
	#print(int(minutes.rotation_degrees))
	# Si la rotacion supera los 360 grados, volver a 0
	if minutes.rotation_degrees >= 360:
		minutes.rotation_degrees = 0


func _on_hour_button_pressed():
	hours.rotation_degrees += 30
	#print(int(hours.rotation_degrees))
	if hours.rotation_degrees >= 360:
		hours.rotation_degrees = 0
	
