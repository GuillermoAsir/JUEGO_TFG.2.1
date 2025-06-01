# GlobalAudio.gd
extends Node

@onready var click_sound := $ClickSound as AudioStreamPlayer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # Asegúrate de que el cursor esté visible

func _input(event):
	# Escuchar solo clics del ratón
	if event is InputEventMouseButton and event.pressed:
		if click_sound:
			click_sound.play()
