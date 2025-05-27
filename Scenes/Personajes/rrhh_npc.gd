extends CharacterBody2D

@onready var rr_hh = $rr_hh as AnimatedSprite2D

func _ready():
	# Conectamos la señal "animation_finished"
	rr_hh.connect("animation_finished", Callable(self, "_on_rr_hh_animation_finished"))
	
	# Iniciamos la animación "appear"
	rr_hh.play("appear")
	rr_hh.set_animation_loop("appear", false)  # Para que no se repita

func _on_rr_hh_animation_finished():
	if rr_hh.animation == "appear":
		rr_hh.play("idle")
