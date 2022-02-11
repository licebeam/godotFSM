extends KinematicBody2D

var velocity = Vector2();

export var maxTimer = 128
var timerRight = maxTimer;
var timerLeft = maxTimer;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP); 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
			
	if(timerRight >= 1):
		timerRight -= 1;
		velocity.x = 30;
		
	if(timerRight <= 0):
		velocity.x = -30;
		timerLeft -= 1;
	
	if(timerLeft <= 0):
		# reset
		timerLeft = maxTimer;
		timerRight = maxTimer;
		velocity.x = 0;
#	pass
