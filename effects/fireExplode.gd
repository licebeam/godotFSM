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
	position.y += rand_range(-8, 8);
	position.x += rand_range(-8, 8);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y -= rand_range(0.1, 1);
#	pass
