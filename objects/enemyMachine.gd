extends "res://enemy/enemyMachine.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	health = 1;
	knockBackDisabled = true;
	gravityDisabled = true;
	screenShakeDisabled = true;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
