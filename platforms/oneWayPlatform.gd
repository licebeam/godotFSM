extends Node2D

export(NodePath) var area;
export(NodePath) var collider;

onready var area2d = get_node(area);
onready var areaCollider = get_node(collider);


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	var overlaps = area2d.get_overlapping_areas()
	if(overlaps.size() >= 1):
		for over in overlaps:
			if(over.name == 'belowBox' && Input.is_action_pressed("down") && Input.is_action_just_pressed('up')):
				var body = over.get_parent()
				body.position = Vector2(body.position.x, body.position.y + 4)
#	pass
