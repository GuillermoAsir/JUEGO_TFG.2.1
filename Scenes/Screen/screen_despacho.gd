extends Node2D

@onready var player := $DespachoGeneral/chico # Asegúrate de que el nombre del jugador sea correcto

func _ready():
	var GLOBAL = get_tree().get_root().get_node("GlobalSave")
	if GLOBAL == null:
		push_error("No se encontró el nodo GLOBAL.")
		return

	if player == null:
		push_error("No se encontró el nodo 'chico' en esta escena.")
		return

	GLOBAL.load_game()

	# Cargar la última posición del jugador, independientemente de la escena
	var pos = GLOBAL.game_data["position"]

	# Ajusta la posición si es muy negativa
	if pos.x < 0:
		pos.x = 100
	if pos.y < 0:
		pos.y = 100

	player.global_position = pos

	if GLOBAL.game_data["first_time_viejo"]:
		$AnimationPlayer.play("habla_viejo")
		GLOBAL.game_data["first_time_viejo"] = false

	# Guardar cambios después de cargar todo
	GLOBAL.save_game()
