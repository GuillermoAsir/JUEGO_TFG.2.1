extends Area2D

func _on_cerrar_juego_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Cerrando juego...")
		get_tree().quit()
