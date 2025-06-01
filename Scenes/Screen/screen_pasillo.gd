extends Node2D

@onready var player := $chico # Asegúrate de que el nombre del jugador sea correcto

func _ready():
	var GLOBAL = get_tree().get_root().get_node("GlobalSave")
	if GLOBAL == null:
		push_error("No se encontró el nodo GLOBAL.")
		return

	GLOBAL.load_game()

	# Cargar la última posición del jugador, independientemente de la escena
	player.global_position = GLOBAL.game_data["position"]

	# Reproducir animaciones solo la primera vez (opcional)
	if GLOBAL.game_data["first_time_rrhh"]:
		$AnimationPlayerRRHH.play("aparición_rrhh")
		GLOBAL.game_data["first_time_rrhh"] = false

	if GLOBAL.game_data["first_time_pam"]:
		$AnimationPlayerPam.play("hablar_pam")
		GLOBAL.game_data["first_time_pam"] = false

	# Guardar cambios después de cargar todo
	GLOBAL.save_game()
