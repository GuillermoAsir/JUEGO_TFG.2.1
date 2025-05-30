extends Area2D

@export var next_scene_path: String = ""

var label: Label

func _ready():
	# Usa la ruta relativa desde el propio EntradaDespacho
	label = get_node_or_null("CanvasLayer/Label")
	if label:
		label.hide()
	else:
		print("❌ No se encontró el Label.")

func _on_body_entered(body):
	print("Body entró:", body.name)
	if body.name == "chico":
		if label:
			label.show()
		else:
			print("❌ No se puede mostrar el Label porque es nulo.")

func _on_body_exited(body):
	print("Body salió:", body.name)
	if body.name == "chico":
		if label:
			label.hide()
		else:
			print("❌ No se puede ocultar el Label porque es nulo.")

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_E:
		change_scene()

func change_scene():
	if next_scene_path != "":
		get_tree().change_scene_to_file(next_scene_path)
	else:
		print("❌ No se ha configurado la ruta de la escena.")
