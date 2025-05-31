extends Area2D

@export var camara_lejos: Camera2D
@export var camara_cerca: Camera2D

var camara_actual_cerca := false

func cambiar_camara():
	if camara_actual_cerca:
		camara_lejos.make_current()
	else:
		camara_cerca.make_current()
	camara_actual_cerca = !camara_actual_cerca

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		cambiar_camara()
