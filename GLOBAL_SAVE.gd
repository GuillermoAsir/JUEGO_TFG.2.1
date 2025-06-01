# GLOBAL_SAVE.gd - Script global en Autoload
extends Node

var save_path: String = "user://save_game.dat"

var game_data: Dictionary = {
	"position": Vector2(75, 202), # Posición inicial por defecto
	"first_time_rrhh": true,
	"first_time_pam": true,
	"first_time_viejo": true,
}

func save_game() -> void:
	var file := FileAccess.open(save_path, FileAccess.WRITE)
	if file:
		file.store_var(game_data)
		file.close()

func load_game() -> void:
	if FileAccess.file_exists(save_path):
		var file := FileAccess.open(save_path, FileAccess.READ)
		if file:
			game_data = file.get_var()
			file.close()
