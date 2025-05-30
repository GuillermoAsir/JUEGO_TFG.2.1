extends Area2D

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		cargar_escena_game()

func cargar_escena_game():
	var escena_game := preload("res://Scenes/Escenarios/Escritorio.tscn")
	var instancia := escena_game.instantiate()
	if instancia:
		add_child(instancia)  # O usar otro nodo padre adecuado como get_node("UI") si es para mostrarla
