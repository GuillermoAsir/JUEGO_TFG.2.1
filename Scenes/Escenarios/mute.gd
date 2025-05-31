extends Area2D

@export var musica_fondo: AudioStreamPlayer

var esta_muteado := false

func _on_muteador_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		esta_muteado = !esta_muteado
		musica_fondo.volume_db = -80 if esta_muteado else -22.285
