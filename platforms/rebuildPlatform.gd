extends Node2D

export(NodePath) var animator;
export(NodePath) var body;
export(NodePath) var area;
export(NodePath) var collider;

onready var myBody = get_node(body);
onready var anim = get_node(animator);
onready var area2d = get_node(area);
onready var areaCollider = get_node(collider);

export var maxBreakTime = 12;
export var maxRebuildTime = 32;
var breakTimer = maxBreakTime;
var rebuildTimer = maxRebuildTime;
var maxResetFrames = 10;
var resetFrames = maxResetFrames;

# Called when the node enters the scene tree for the first time.
func _ready():
	anim.play('start')
	myBody.set_disabled(false);
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	if(breakTimer >= 1):
		var overlaps = area2d.get_overlapping_areas()
		if(overlaps.size() >= 1 && breakTimer >= 1 ):
			for over in overlaps:
				if(over.name == 'footBox'):
					rebuildTimer = maxRebuildTime;
					breakTimer -=1;
		
	if(rebuildTimer >= 1):
		rebuildTimer -= 1;
					
	if(rebuildTimer <= 0):
		myBody.set_disabled(false);
		anim.play('start')
		rebuildTimer = maxRebuildTime;
		breakTimer = maxBreakTime
		
	if(breakTimer <= 0):
		myBody.set_disabled(true);
		anim.play('rebuild')
		breakTimer = maxBreakTime
		

#	pass
