extends Node

class_name PuzzleData

var path_file: String
var data_file
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
	load_json_file()
	
func load_json_file():
	if FileAccess.file_exists(path_file):
		data_file = FileAccess.open(path_file,FileAccess.READ_WRITE)
		puzzle_data = JSON.parse_string(data_file.get_as_text())
		data_file.close()
	else:
		create_json_file()

func create_json_file():
	var json_string = JSON.stringify(puzzle_data)
	var json = JSON.new()
	var error = json.parse(json_string)
	if error == OK:
		var data_received = json.data
		if typeof(data_received) == TYPE_DICTIONARY:
			print(data_received)
		else:
			print("Unexpected data")
	else:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
	
	save_file(json_string)

func save_file(content):
	data_file = FileAccess.open(path_file,FileAccess.WRITE)
	data_file.store_string(content)
	data_file.close()

func update_puzzle(puzzle: String, value: bool):
	puzzle_data[puzzle] = value
	var data = JSON.stringify(puzzle_data)
	save_file(data)

func get_puzzle_state(puzzle: String):
	return puzzle_data[puzzle]
