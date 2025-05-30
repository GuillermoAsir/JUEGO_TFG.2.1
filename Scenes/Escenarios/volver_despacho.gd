extends Button

@export var ruta_escena: String = "res://Scenes/Screen/Screen_despacho.tscn"

func _on_Button_pressed():
	print("✅ Botón presionado. Intentando cambiar a:", ruta_escena)
	
	var escena = ResourceLoader.load(ruta_escena)
	
	if escena:
		print("🔁 Cambiando a la escena...")
		get_tree().change_scene_to_packed(escena)
	else:
		print("❌ No se pudo cargar la escena:", ruta_escena)
		push_error("No se pudo cargar la escena: " + ruta_escena)
