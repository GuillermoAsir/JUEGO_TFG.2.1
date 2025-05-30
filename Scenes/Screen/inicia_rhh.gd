extends Area2D

@export var animacion: NodePath = ""
@export var dialogo: NodePath = ""

var dialogo_mostrado := false

func _on_body_entered(body):
	if body.name == "chico" and not dialogo_mostrado:
		mostrar_contenido()
		get_tree().create_timer(2.0).connect("timeout", Callable(self, "_mostrar_dialogo"))
		dialogo_mostrado = true

func mostrar_contenido():
	var animacion_nodo = get_node_or_null(animacion)
	if animacion_nodo:
		animacion_nodo.show()
		animacion_nodo.play()

func _mostrar_dialogo():
	var dialogo_nodo = get_node_or_null(dialogo)
	if dialogo_nodo:
		dialogo_nodo.show()

var timer : Timer = null
