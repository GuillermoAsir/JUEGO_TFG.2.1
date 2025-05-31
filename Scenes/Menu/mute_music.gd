extends Area2D

@export var musica_fondo: AudioStreamPlayer

var ya_muteado := false

func _on_mute_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		# Solo mutea si el volumen actual no está ya muteado
		if musica_fondo.volume_db > -79:
			musica_fondo.volume_db = -80
