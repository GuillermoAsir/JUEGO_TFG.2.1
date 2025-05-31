extends Area2D

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		cargar_escena_game()

func cargar_escena_game():
	get_tree().change_scene_to_file("res://game.tscn")
