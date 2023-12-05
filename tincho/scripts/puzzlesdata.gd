extends Node

class_name PuzzleData

# Ruta del archivo JSON
var path_file: String
# Variable que servira para cargar el archivo
var data_file
# Diccionario que contendra el estado de los puzzles
var puzzle_data: Dictionary = {
	"2023": false,
	"1954": false,
	"1924": false,
	"5423": false,
	"2454": false,
	"2423": false
}

func _init(path) -> void:
	self.path_file = path
	# Ni bien se inicializa, cargar el archivo
	load_json_file()
	
func load_json_file():
	# Si el archivo existe, asignar la informacion a la variable puzzle_data
	if FileAccess.file_exists(path_file):
		# Abrir archivo en modo lectura
		data_file = FileAccess.open(path_file,FileAccess.READ)
		# Convertir JSON en diccionario
		puzzle_data = JSON.parse_string(data_file.get_as_text())
		# Cerrar archivo
		data_file.close()
	# Si el archivo no existe, crearlo
	else:
		create_json_file()

func create_json_file():
	# Convertir diccionario a string en formato json
	var json_string = JSON.stringify(puzzle_data)
	# Crear objeto json para verificar errores
	var json = JSON.new()
	var error = json.parse(json_string)
	# Verificar si existen errores y si el formato es correcto
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_DICTIONARY:
			print(data_received)
		else:
			print("Unexpected data")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
	
	# Guardar archivo
	save_file(json_string)

func save_file(content):
	# Abrir archivo en modo escritura
	data_file = FileAccess.open(path_file,FileAccess.WRITE)
	# Escribir archivo
	data_file.store_string(content)
	data_file.close()

func update_puzzle(puzzle: String, value: bool) -> void:
	# Actualizar valor de diccionario
	puzzle_data[puzzle] = value
	# Convertir diccionario a String en formato JSON
	var data = JSON.stringify(puzzle_data)
	# Guardar archivo 
	save_file(data)

func get_puzzle_state(puzzle: String) -> bool:
	# Cargar nuevamente el archivo para actualizar valores
	load_json_file()
	# Obtener valor de diccionario
	return puzzle_data[puzzle]
