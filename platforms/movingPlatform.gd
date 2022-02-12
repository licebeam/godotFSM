extends KinematicBody2D

var velocity = Vector2();

onready var collider = get_node("standZoneMove");

export var maxTimer = 256
var timerRight = maxTimer;
var timerLeft = maxTimer;
var playerOn = false;

var player = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP); 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#handle hitbox - stuff that makes me take damage
	var overlaps = collider.get_overlapping_areas()
	if(overlaps.size() >= 1):
		for over in overlaps:
			#defaulting case for when the player walks
			if(over.name == 'playerHurtBox' && !playerOn && player && player.state.name != 'walk' && player.state.name != 'jump'):
				playerOn = true;
				
	if(player && playerOn && player.state.name != 'walk' && player.state.name != 'jump'):
		player.velocity.x = velocity.x;	
	#disable velocity	
	if(player && playerOn && (player.state.name == 'walk' || player.state.name == 'jump')):
		player.velocity.x = 0;
		playerOn = false;	
			
	if(timerRight >= 1):
		timerRight -= 1;
		velocity.x = 15;
		
	if(timerRight <= 0):
		velocity.x = -15;
		timerLeft -= 1;
	
	if(timerLeft <= 0):
		# reset
		timerLeft = maxTimer;
		timerRight = maxTimer;
		velocity.x = 0;
#	pass

func _on_standZoneMove_area_entered(area):
	if(area.name != 'width'):
		player = get_node('/root/World/Player/body/stateMachine')
	pass # Replace with function body.

func _on_standZoneMove_area_exited(area):
	if(area.name != 'width'):
		playerOn = false;
	pass # Replace with function body.
