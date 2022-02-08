extends Node2D

export(NodePath) var animator;
export(NodePath) var mySprite;

onready var anim = get_node(animator);
onready var sprite = get_node(mySprite);

func _ready():
	anim.play('slash');
	pass # Replace with function body.

func kill(): 
	queue_free()

func setPosition(flip, crouch):
	if crouch: 
		position.y += 4
	else: 
		position.y += 2
	if(flip):
		sprite.set_flip_h(true);
		position.x -= 15;
	else: 
		sprite.set_flip_h(false);
		position.x += 15;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
