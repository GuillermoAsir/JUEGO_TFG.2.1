extends CharacterBody2D

# Configuración básica
const SPEED = 400.0
var appeared: bool = true
var puede_moverse: bool = true  # Nueva variable

# Guardado
var GLOBAL = null
var time_since_last_save := 0.0
const SAVE_INTERVAL = 1.0 # segundos

# Sonido de pasos
@onready var audio_pasos := $Audio_pasos as AudioStreamPlayer
var is_playing_steps = false

# Dirección anterior para detectar cambio de movimiento
var previous_direction := Vector2.ZERO

func _ready():
	GLOBAL = get_tree().get_root().get_node("GlobalSave")
	add_to_group("Player")

func _physics_process(delta):
	if not puede_moverse:
		print("🚫 Movimiento bloqueado")  # <-- Mensaje en consola
		velocity = Vector2.ZERO
		audio_pasos.stop()
		is_playing_steps = false
		return

	# Control con W, A, S, D
	var dir_x = 0
	if Input.is_key_pressed(KEY_A):
		dir_x = -1
	elif Input.is_key_pressed(KEY_D):
		dir_x = +1

	var dir_y = 0
	if Input.is_key_pressed(KEY_W):
		dir_y = -1
	elif Input.is_key_pressed(KEY_S):
		dir_y = +1

	var direction = Vector2(dir_x, dir_y).normalized()

	velocity = direction * SPEED
	move_and_slide()

	decide_animation(direction)

	if direction != Vector2.ZERO:
		if direction != previous_direction and audio_pasos:
			audio_pasos.play()
			is_playing_steps = true
	elif direction == Vector2.ZERO and is_playing_steps:
		audio_pasos.stop()
		is_playing_steps = false

	previous_direction = direction

	time_since_last_save += delta
	if time_since_last_save >= SAVE_INTERVAL and GLOBAL != null:
		GLOBAL.game_data["position"] = global_position
		GLOBAL.save_game()
		time_since_last_save = 0.0

func decide_animation(direction := Vector2.ZERO):
	if not appeared:
		return

	if direction == Vector2.ZERO:
		$animaciones.play("idle")
	else:
		if abs(direction.y) > abs(direction.x):
			if direction.y < 0:
				$animaciones.play("up_run")
			else:
				$animaciones.play("down_run")
		else:
			$animaciones.flip_h = direction.x < 0
			$animaciones.play("run")

func load_position():
	if GLOBAL != null:
		global_position = GLOBAL.game_data.get("position", Vector2(75, 202))

func save_current_position(scene_name: String):
	if GLOBAL != null:
		GLOBAL.game_data["position_" + scene_name] = global_position
		GLOBAL.game_data["last_scene"] = scene_name
		GLOBAL.save_game()

# --- NUEVAS FUNCIONES para controlar el movimiento desde el AnimationPlayer ---
func bloquear_movimiento():
	puede_moverse = false
	audio_pasos.stop()
	is_playing_steps = false

func desbloquear_movimiento():
	puede_moverse = true
