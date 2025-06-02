# GlobalAudio.gd
extends Node

@onready var click_sound := $ClickSound as AudioStreamPlayer
@onready var maquina_escribir := $MaquinaEscribir as AudioStreamPlayer
@onready var timbre := $Timbre2 as AudioStreamPlayer

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE) # Asegúrate de que el cursor esté visible

func _input(event):
	# Escuchar clics del ratón
	if event is InputEventMouseButton and event.pressed:
		if click_sound:
			click_sound.play()

	# Escuchar teclas del teclado
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER:  # Tecla Intro
			if timbre:
				timbre.play()
		else:  # Cualquier otra tecla
			if maquina_escribir:
				maquina_escribir.play()
