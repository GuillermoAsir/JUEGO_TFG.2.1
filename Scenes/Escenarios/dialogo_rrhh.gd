extends Sprite2D

@export var texto: String = ""
var index = 0

func _set_texto(value):
	print("Mostrando texto:", value)
	visible = true
	texto = value
	index = 0
	$Label.text = ""
	$timer.start()

func _on_timer_timeout():
	if index >= texto.length():
		$timer_esconde.start()
		$timer.stop()
	else:
		$Label.text = $Label.text + texto[index]
		index += 1

func _ready():
	pass

func _process(delta):
	pass

func _on_timer_esconde_timeout() -> void:
	visible = false
	$Label.text = ""
	index = 0
