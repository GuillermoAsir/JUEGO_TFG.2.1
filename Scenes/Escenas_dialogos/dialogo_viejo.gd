extends Node2D

# Propiedades exportadas
@export var velocidad_mostrar: float = 0.05
@export var tiempo_ocultar: float = 1.5
@export var lineas_por_bloque: int = 3

# Variables
var index = 0
var label
var timer_mostrar
var timer_ocultar
var dialogo_actual: String = ""
var fragmentos: Array = []
var indice_fragmento: int = 0

# Diálogos incrustados directamente en el script
const DIALOGO_BYTEYAGI_1 := """
Carambita carambola, ya tenemos aquí al chico/a de prácticas.
Me presento, mi nombre es Maestro Byteyagi y llevo en esta empresa más de 35 años.
En mis tiempos usábamos como tecnología a una médium y a una tabla ouija.

Yo seré tu maestro Yoga, tu Iruka Umino, tu maestro Mutenroshi.
Te guiaré por la senda de la sabiduría. Serás mi discípulo,
y si tienes alguna duda, aprovecha porque en unos meses me jubilo.

Bueno, empecemos por lo más básico: te explicaré la estructura de esta empresa.
En esta empresa tenemos a la encantadora recepcionista Pam,
a ella le puedes preguntar si te llegó alguna incidencia.

Luego tenemos el departamento de contabilidad... esperemos que les cuadres.
¡Eh! Lo pillas, lo pillas...
Después está el departamento de ventas:
Para ellos, 'el error es del usuario' es un mito.

Para nosotros, es la causa raíz del 99% de los problemas.
Luego está el departamento de marketing, expertos en hacer que ‘próximamente’ suene como si fuera mañana.
Y por último, el departamento de recursos humanos... que de humanos tienen poco.
"""

const DIALOGO_BYTEYAGI_2 := """
Vaya, vaya... a alguien se le hundió el barco.
Mira tu archivo donde tienes las IPs de la empresa.
Se llama IPS_Departamentos.txt y está en tu directorio personal, en la carpeta Documentos.

La ruta absoluta es /home/usuario/Documentos.
Vas a usar la terminal, para poder navegar por las carpetas es muy sencillo.
Usarás el comando cd, por ejemplo: cd /home/usuario/Documentos.

Hazlo y mira la magia.
Así que acércate a tu ordenador cuando puedas.
Pulsa E para encenderlo y estarás en el plano Despacho - Escritorio.
Abre la terminal... y manos a la obra.
"""

# Inicialización de nodos
func _ready():
	print("Nodo Diálogo inicializado")

	# Acceso a los nodos hijos
	label = $Label
	timer_mostrar = $Timer
	timer_ocultar = $TimerOcultar

	# Conectar señales de los timers
	timer_mostrar.connect("timeout", Callable(self, "_on_Timer_timeout"))
	timer_ocultar.connect("timeout", Callable(self, "_on_TimerOcultar_timeout"))

	# Habilitar entrada de teclado
	set_process_input(true)

	# Iniciar automáticamente el primer diálogo
	iniciar_dialogo("byteyagi_1")

# Método para seleccionar e iniciar un diálogo
func iniciar_dialogo(id_dialogo: String):
	visible = true
	var texto_completo := ""

	if id_dialogo == "byteyagi_1":
		texto_completo = DIALOGO_BYTEYAGI_1
	elif id_dialogo == "byteyagi_2":
		texto_completo = DIALOGO_BYTEYAGI_2
	else:
		print("Diálogo no encontrado:", id_dialogo)
		return

	fragmentos = dividir_en_bloques(texto_completo)
	indice_fragmento = 0
	mostrar_siguiente_fragmento()

# Divide el texto completo en fragmentos según el número de líneas
func dividir_en_bloques(dialogo: String) -> Array:
	var lineas = dialogo.split("\n")
	var resultado := []

	for i in range(0, lineas.size(), lineas_por_bloque):
		var sub_array = []
		for j in range(lineas_por_bloque):
			if i + j < lineas.size():
				sub_array.append(lineas[i + j])
		resultado.append("\n".join(sub_array))

	return resultado

# Muestra el siguiente fragmento del diálogo
func mostrar_siguiente_fragmento():
	if indice_fragmento >= fragmentos.size():
		queue_free()  # Cierra el nodo cuando termina el diálogo
		return

	dialogo_actual = fragmentos[indice_fragmento]
	indice_fragmento += 1
	index = 0
	label.text = ""

	# Añadir indicador visual si quedan más fragmentos
	if indice_fragmento < fragmentos.size():
		dialogo_actual += "\n\n ▼"

	timer_mostrar.start(velocidad_mostrar)

# Manejar el timeout del timer de mostrar texto
func _on_Timer_timeout():
	if index < dialogo_actual.length():
		label.text += dialogo_actual[index]
		index += 1
	else:
		timer_mostrar.stop()
		timer_ocultar.start(tiempo_ocultar)

# Manejar el timeout del timer de ocultar diálogo
func _on_TimerOcultar_timeout():
	pass  # No hacemos nada, solo esperamos a Intro

# Manejar entrada del teclado/ratón
func _input(event):
	if event.is_action_pressed("ui_accept"):
		timer_mostrar.stop()
		timer_ocultar.stop()
		mostrar_siguiente_fragmento()
