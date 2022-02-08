extends Node2D

export(NodePath) var animator;

onready var anim = get_node(animator);

func _ready():
	anim.play('puff');
	pass # Replace with function body.

func kill(): 
	queue_free()

func setPosition(newPos):
	set_position(newPos)
	position.y += 42;
	position.x += 31;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
