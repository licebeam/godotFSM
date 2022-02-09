extends Camera2D

var shake_amount = 1.0
var isShaking = false;
export var maxShakeTime = 6
var shakeTime = maxShakeTime;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if isShaking && shakeTime >= 1: 
		shakeTime -= 1;
		set_offset(Vector2( \
			rand_range(-1.0, 1.0) * shake_amount, \
			rand_range(-1.0, 1.0) * shake_amount \
		))
	else: 
		isShaking = false;
		shakeTime = maxShakeTime;
