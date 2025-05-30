extends Node2D

# Propiedades exportadas
@export var texto: String = ""  # Texto del diálogo
@export var velocidad_mostrar: float = 0.050  # Velocidad de escritura letra por letra
@export var tiempo_ocultar: float = 5  # Tiempo antes de ocultar el diálogo

# Variables
var index = 0
var label
var timer_mostrar
var timer_ocultar

# Inicialización de nodos
func _ready():
	print("Nodo Diálogo inicializado")
	
	# Acceso a los nodos hijos
	label = $Label
	timer_mostrar = $Timer
	timer_ocultar = $TimerOcultar
	
	# Conectar señales de los timers
	timer_mostrar.connect("timeout", Callable(self, "_on_Timer_timeout"))
	timer_ocultar.connect("timeout", Callable(self, "_on_Timer_timeout"))

	# Llamar automáticamente al método _set_texto() con un texto predeterminado
	_set_texto("Hola, usuario nos alegra mucho que hayas elegido Cyberdyne Systems para realizar tus prácticas, 
	aquí te formaremos lo mejor posible para que des tu salto al mundo laboral. En esta empresa no escatimamos 
	en gastos. Hoy empezaras con el maestro Byteyagi, se llama Juan, pero quiere que le llamemos así...
	él te ira guiando en lo que necesites, dirígete hacia tu oficina veras una placa que pone Informática. 
	Espero que disfrutes del ambiente laboral. Me tienes para lo que necesitas soy Rosa Melano 
	de Recursos Humanos.")

# Método para iniciar el diálogo
func _set_texto(value):
	print("Mostrando texto:", value)
	visible = true
	texto = value
	index = 0
	label.text = ""
	timer_mostrar.start(velocidad_mostrar)  # Iniciar el temporizador con la velocidad especificada

# Manejar el timeout del timer de mostrar texto
func _on_Timer_timeout():
	if index < texto.length():
		label.text += texto[index]
		index += 1
	else:
		timer_mostrar.stop()
		timer_ocultar.start(tiempo_ocultar)

# Manejar el timeout del timer de ocultar diálogo
func _on_TimerOcultar_timeout():
	visible = false
	label.text = ""
	index = 0

#Pulsa intro para cerrar diálogo
func _input(event):
	if event.is_action_pressed("ui_accept"):
		timer_mostrar.stop()
		timer_ocultar.stop()

		# Mostrar todo el texto instantáneamente
		label.text = texto
		index = texto.length()

		# Cerrar inmediatamente o dar un breve delay
		_on_TimerOcultar_timeout()
