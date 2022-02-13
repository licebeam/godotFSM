extends ParallaxLayer

export(float) var SPEED = -18;
export(float) var DROP = 1;

var maxTimer = 120;
var timer = maxTimer;
var isUp = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.motion_offset.x += SPEED * delta;
	
	if timer >= 1 && !isUp:
		timer -= 1;
		self.motion_offset.y += DROP * delta;
		
	if timer >= 1 && isUp:
		timer -= 1;
		self.motion_offset.y -= DROP * delta;
	
	if timer <= 0 && isUp:
		timer = maxTimer;
		isUp = false;
		
	if timer <= 0 && !isUp:
		timer = maxTimer;
		isUp = true;
#	pass
