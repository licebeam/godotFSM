extends Node2D

export(NodePath) var animator;
export(NodePath) var hitbox

onready var myHitBox = get_node(hitbox);
onready var anim = get_node(animator);

var maxFlameTimer = 120;
var fireTimer = maxFlameTimer;
var fireDuration = maxFlameTimer;

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play('idle')
	myHitBox.set_disabled(true);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fireTimer -= 1;
	
	if fireTimer <= 0:
		anim.play('spire');
		fireDuration -= 1;
		myHitBox.set_disabled(false);
		
	if fireTimer <= 0 && fireDuration <= 0:
		fireDuration = maxFlameTimer;
		fireTimer = maxFlameTimer;
		anim.play('idle')
		myHitBox.set_disabled(true);
#	pass
