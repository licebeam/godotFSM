extends Node2D

export(NodePath) var animator;
onready var anim = get_node(animator);

var fireTimer = 60;
var fireDuration = 120;

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play('idle')
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fireTimer -= 1;
	
	if fireTimer <= 0:
		anim.play('spire');
		fireDuration -= 1;
		
	if fireTimer <= 0 && fireDuration <= 0:
		fireDuration = 120;
		fireTimer = 60;
		anim.play('idle')
#	pass
