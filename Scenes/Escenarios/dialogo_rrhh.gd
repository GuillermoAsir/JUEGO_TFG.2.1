extends Sprite2D

@export var texto:String = "":
	set(value):
		visible= true
		texto = value
		$timer.start()

var index = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	$Label.text = $Label.text + texto[index]
	index += 1
	pass # Replace with function bod


func _on_timer_esconde_timeout() -> void:
	pass # Replace with function body.
