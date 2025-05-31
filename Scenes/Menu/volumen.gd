extends Area2D

@export var musica_fondo: AudioStreamPlayer
@export var muteador: Node  # Referencia al nodo Muteador (el otro Area2D)

func _on_volumen_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if musica_fondo.volume_db <= -79:
			musica_fondo.volume_db = -22.585
