extends CharacterBody2D

const SPEED = 200.0
enum Estado { CAMINANDO_DERECHA, PARADO, CAMINANDO_IZQUIERDA, PEO }

var estado_actual = Estado.PARADO
var is_farting = false
var peo_pendiente = false
var ultima_direccion = "derecha"  # Control del ciclo

@onready var animaciones = $animaciones
@onready var fart_sound = $FartSound
@onready var fart_timer = Timer.new()
@onready var estado_timer = Timer.new()

func _ready():
	add_child(fart_timer)
	add_child(estado_timer)

	fart_timer.wait_time = 10.0
	fart_timer.one_shot = false
	fart_timer.timeout.connect(_on_fart_timer_timeout)
	fart_timer.start()

	estado_timer.one_shot = true
	estado_timer.timeout.connect(_on_estado_timer_timeout)

	print("🟢 [INICIO] Caminando hacia la derecha 8 segundos")
	iniciar_estado(Estado.CAMINANDO_DERECHA, 8.0)

func _physics_process(_delta):
	match estado_actual:
		Estado.CAMINANDO_DERECHA:
			velocity.x = SPEED
		Estado.CAMINANDO_IZQUIERDA:
			velocity.x = -SPEED
		_:
			velocity.x = 0

	move_and_slide()

	if peo_pendiente and puede_hacer_peo():
		peo_pendiente = false
		await reproducir_peo()

	if is_farting and abs(velocity.x) > 0:
		cancelar_peo()

	decide_animation()

func decide_animation():
	if is_farting:
		return

	match estado_actual:
		Estado.CAMINANDO_DERECHA:
			animaciones.flip_h = false
			animaciones.play("run")
		Estado.CAMINANDO_IZQUIERDA:
			animaciones.flip_h = true
			animaciones.play("run")
		_:
			animaciones.play("idle")

func puede_hacer_peo() -> bool:
	return estado_actual == Estado.PARADO and velocity.length() == 0

func cancelar_peo():
	if is_farting:
		is_farting = false
		print("⛔ [CANCELADO] Peo cancelado por movimiento")
		animaciones.stop()
		decide_animation()

func reproducir_peo() -> void:
	is_farting = true
	estado_actual = Estado.PEO
	print("💨 [PEO] Reproduciendo animación de peo")

	animaciones.play("peo")
	#fart_sound.play()

	# Esperar 2 segundos (independientemente de si la animación tiene signal o no)
	await get_tree().create_timer(2.0).timeout

	is_farting = false
	print("✅ [PEO] Animación terminada")

	# Después del peo, cambiar dirección
	if ultima_direccion == "derecha":
		print("⬅️ [SIGUIENTE] Caminando a la izquierda 8 segundos")
		ultima_direccion = "izquierda"
		iniciar_estado(Estado.CAMINANDO_IZQUIERDA, 8.0)
	else:
		print("➡️ [SIGUIENTE] Caminando a la derecha 8 segundos")
		ultima_direccion = "derecha"
		iniciar_estado(Estado.CAMINANDO_DERECHA, 8.0)


func _on_fart_timer_timeout():
	if not is_farting:
		if puede_hacer_peo():
			print("⏱️ [TEMPORIZADOR] Peo iniciado automáticamente")
			await reproducir_peo()
		else:
			print("⏳ [PENDIENTE] Peo pospuesto hasta estar quieto")
			peo_pendiente = true

func iniciar_estado(nuevo_estado: int, duracion: float):
	estado_actual = nuevo_estado
	estado_timer.start(duracion)
	match nuevo_estado:
		Estado.CAMINANDO_DERECHA:
			print("➡️ [ESTADO] Caminando hacia la derecha")
		Estado.CAMINANDO_IZQUIERDA:
			print("⬅️ [ESTADO] Caminando hacia la izquierda")
		Estado.PARADO:
			print("⏹️ [ESTADO] Parado")
		Estado.PEO:
			print("💨 [ESTADO] Peo")
	decide_animation()

func _on_estado_timer_timeout():
	if estado_actual in [Estado.CAMINANDO_DERECHA, Estado.CAMINANDO_IZQUIERDA]:
		print("🛑 [TIEMPO] Fin del movimiento. Estado: PARADO")
		estado_actual = Estado.PARADO
		decide_animation()
