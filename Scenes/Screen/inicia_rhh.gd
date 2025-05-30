extends Area2D

@export var animacion: NodePath
@export var dialogo: NodePath

var dialogo_mostrado := false

func _ready():
	# Ocultar diálogo al inicio
	var dialogo_nodo = get_node_or_null(dialogo)
	if dialogo_nodo:
		dialogo_nodo.visible = false

func _on_IniciaRhh_body_entered(body):
	if body.name == "chico" and not dialogo_mostrado:
		dialogo_mostrado = true
		reproducir_animacion()
		await get_tree().create_timer(2.0).timeout
		mostrar_dialogo()

func reproducir_animacion():
	var anim = get_node_or_null(animacion)
	if anim and anim is AnimationPlayer:
		anim.play("AnimationPlayerRRHH")  # Asegúrate que este nombre coincida exactamente

func mostrar_dialogo():
	var dialogo_nodo = get_node_or_null(dialogo)
	if dialogo_nodo:
		dialogo_nodo.visible = true

func _on_AnimationPlayerRRHH_animation_finished(anim_name):
	if anim_name == "AnimationPlayerRRHH":
		# Activar la cámara tras la animación
		var camara = get_node_or_null("/root/Node2D/Camera2DRRHH")  # Ajusta la ruta si es diferente
		if camara and camara is Camera2D:
			camara.make_current()
