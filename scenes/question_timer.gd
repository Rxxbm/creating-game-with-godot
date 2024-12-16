extends Label

var time = 0
var seconds = 0
var res = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta 
	seconds = fmod(time, 60)
	res = 30 - seconds
	$".".text = "%02d" % res

	
