extends Area2D

@export var anim_player_path: NodePath
var jugador_en_area := false
var jugador: Node2D = null

func _ready():
	# Asegúrate de que el nodo AnimationPlayer está accesible
	if not has_node(anim_player_path):
		push_error("No se encontró el AnimationPlayer en la ruta especificada")

func _process(delta):
	if jugador_en_area and Input.is_key_pressed(Key.KEY_H):  # Detecta la tecla H
		var anim_player = get_node_or_null(anim_player_path)
		if anim_player and anim_player is AnimationPlayer:
			anim_player.play("AnimationPlayerPam")  # Reemplaza con el nombre real

func _on_body_entered(body: Node2D) -> void:
	if body.name == "chico":  # o usa body.is_in_group("jugador") si usas grupos
		jugador_en_area = true
		jugador = body

func _on_body_exited(body: Node2D) -> void:
	if body == jugador:
		jugador_en_area = false
		jugador = null

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "AnimationPlayerPam":
		print("Animación terminada.")
