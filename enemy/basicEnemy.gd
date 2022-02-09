extends Node2D

export(NodePath) var area2d;
onready var collider = get_node(area2d);
export(NodePath) var animator;
onready var anim = get_node(animator);

var hurt = false;
var health = 5;

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play('idle')
	pass # Replace with function body.

func setNotHurt():
	anim.play('idle')
	hurt = false;

func destroySelf():
	queue_free();

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(health <= 0):
		destroySelf();
	
	var overlaps = collider.get_overlapping_areas()
	if(overlaps.size() >= 1 && !hurt):
		if(overlaps[0].name == 'slashArea'):
			anim.play('hurt')
			hurt = true;
			health -= 1;
#	pass
