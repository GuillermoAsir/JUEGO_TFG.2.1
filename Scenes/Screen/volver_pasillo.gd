extends Area2D

@export var next_scene_path: String = ""

var label: Label

func _ready():
	# Usa la ruta relativa desde el propio VolverPasillo
	label = get_node_or_null("CanvasLayer/Label")
	if label:
		label.hide()
	else:
		print("❌ No se encontró el Label.")

func _on_body_entered(body):
	print("Body entró:", body.name)
	if body.name == "chico":
		label.show()

func _on_body_exited(body):
	print("Body salió:", body.name)
	if body.name == "chico":
		label.hide()

func _on_volver_pasillo_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		cargar_escena_game()

func cargar_escena_game():
	get_tree().change_scene_to_file("res://Scenes/Screen/Screen_pasillo.tscn")
