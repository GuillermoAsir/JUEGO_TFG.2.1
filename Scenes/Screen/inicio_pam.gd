extends Area2D

@export var animation_player_path: NodePath
var animation_player: AnimationPlayer = null
var jugador_dentro: bool = false

func _ready():
	# Cargar el AnimationPlayer desde el path indicado en el Inspector
	if animation_player_path:
		animation_player = get_node(animation_player_path)
	
	if animation_player:
		animation_player.stop()  # Asegura que no se reproduzca al cargar
		animation_player.connect("animation_finished", Callable(self, "_on_animation_player_animation_finished"))
	else:
		print("ERROR: animation_player no asignado correctamente")

	# Conectar las señales del área
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		jugador_dentro = true
		print("Jugador ha entrado en área")

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("Player"):
		jugador_dentro = false
		print("Jugador ha salido del área")

func _on_input_event(_viewport, event, _shape_idx) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Área clicada, reproduciendo animación")
		reproducir_animacion()

func _input(event: InputEvent) -> void:
	if jugador_dentro and event is InputEventKey and event.pressed and event.keycode == KEY_E:
		print("Tecla E pulsada dentro del área, reproduciendo animación")
		reproducir_animacion()

func reproducir_animacion():
	if animation_player:
		animation_player.play("hablar_pam")
	else:
		print("ERROR: animation_player es null, no se puede reproducir animación")

func _on_animation_player_animation_finished(anim_name: String) -> void:
	print("Animación terminada:", anim_name)
