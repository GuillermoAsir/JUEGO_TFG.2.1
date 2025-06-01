extends CharacterBody2D

const SPEED = 400.0
var appeared: bool = true
var time_since_last_save := 0.0
const SAVE_INTERVAL = 1.0 # segundos

var GLOBAL = null

func _ready():
	GLOBAL = get_tree().get_root().get_node("GlobalSave")

func _physics_process(delta):
	var dir_x = Input.get_axis("ui_left", "ui_right")
	var dir_y = Input.get_axis("ui_up", "ui_down")
	var direction = Vector2(dir_x, dir_y).normalized()

	velocity = direction * SPEED
	move_and_slide()

	decide_animation(direction)

	# Guardar posición periódicamente
	time_since_last_save += delta
	if time_since_last_save >= SAVE_INTERVAL and GLOBAL != null:
		GLOBAL.game_data["position"] = global_position
		GLOBAL.save_game()
		time_since_last_save = 0.0

# --- Nueva función: decide_animation ---
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

# --- Nueva función: Cargar posición del jugador ---
func load_position():
	if GLOBAL != null:
		global_position = GLOBAL.game_data["position"]
