extends Area2D

# Ruta de la escena a cargar (configurable desde el inspector)
@export var ruta_escena: String = "res://game.tscn"

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Clic detectado en CambiarTerminal. Cargando escena...")
		cargar_escena()

func cargar_escena():
	var escena = ResourceLoader.load(ruta_escena)
	if escena:
		get_tree().change_scene_to_packed(escena)
	else:
		print("❌ No se pudo cargar la escena:", ruta_escena)
