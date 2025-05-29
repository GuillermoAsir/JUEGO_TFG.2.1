extends Area2D

@export var camara_lejos: Camera2D
@export var camara_cerca: Camera2D

var camara_actual_cerca := false

#func _on_CambiarCamara_input_event(viewport, event, shape_idx):
	#if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#print("¡Clic detectado!")
		#cambiar_camara()

func cambiar_camara():
	if camara_actual_cerca:
		camara_lejos.current = true
		camara_cerca.current = false
	else:
		camara_cerca.current = true
		camara_lejos.current = false
	camara_actual_cerca = !camara_actual_cerca

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("¡Clic detectado!")
		cambiar_camara()

func _on_cambiar_camara_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("¡Clic detectado desde hijo!")
		cambiar_camara()
