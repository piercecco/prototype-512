extends Node

const SAVEPATH = "res://savegame.bin"

var best_time = 0.0
var total_deaths = 0

var spdrnTimer = false

func _ready():
	var DevReset = false
	if DevReset == true:
		total_deaths = 0
		best_time = 0.0
		save_game()

func save_game():
	var file = FileAccess.open(SAVEPATH, FileAccess.WRITE)
	var data = {
		"best_time": best_time,
		"total_deaths": total_deaths,
	}
	var json_string = JSON.stringify(data)
	file.store_line(json_string)

func load_game():
	var file = FileAccess.open(SAVEPATH, FileAccess.READ)
	if FileAccess.file_exists(SAVEPATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				best_time = current_line["best_time"]
				total_deaths = current_line["total_deaths"]

