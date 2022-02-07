extends Node

## getPlayer information 
var PlayerInfo = Character.new()

signal trasitioned(stateName);

export(NodePath) var initial_state;
export(NodePath) var body;
export(NodePath) var animator;

onready var myBody = get_node(body);
onready var anim = get_node(animator);
onready var state = get_node(initial_state);

#save last state
var lastState = 'idle';

#Movement Variables - jump / falling from youtube tutorial.
var velocity = Vector2.ZERO;
export var jumpHeight = 100;
export var jumpTimeToPeak = 0.4;
export var jumpTimeToDescent = 0.3;
export var maxSpeed = 30;
export var maxFallCoyote = 6;
var fallCoyote = maxFallCoyote; #coyote time is used to help players from making mistakes, allows buffer time before falling.

onready var jumpVelocity = ((2.0 * jumpHeight) / jumpTimeToPeak) * -1.0;
onready var jumpGravity = ((-2.0 * jumpHeight) / (jumpTimeToPeak * jumpTimeToPeak)) * -1.0;
onready var fallGravity = ((-2.0 * jumpHeight) / (jumpTimeToDescent * jumpTimeToDescent)) * -1.0;

func getGravity():
	return jumpGravity if velocity.y < 0.0 else fallGravity;
		
func _ready():
	for child in get_children():
		child.stateMachine = self;
	state.enter(myBody, anim);

func _physics_process(delta):
	if(fallCoyote >= 1 && state.name != 'jump'):
		velocity.y = 0
	else: 
		velocity.y += getGravity() * delta;
	myBody.move_and_slide(velocity, Vector2.UP);
	if !myBody.is_on_floor() && !state.name == 'jump' && !state.name == 'attack' && fallCoyote <= 0: #transition to fall if no state active.
		transitionTo('falling');
	if myBody.is_on_ceiling(): #transition to fall if no state active.
		velocity.y = 0;
		
func getVelocityX():
	if(get_node('../Sprite').flip_h):
		return -velocity.x;
	else: 
		return velocity.x;
		
func _process(delta):
	myBody = get_node(body);
	state.update(delta);
	if(!myBody.is_on_floor() && fallCoyote >= 0):
		fallCoyote -= 1;
	if(myBody.is_on_floor()):
		fallCoyote = maxFallCoyote;
	
func transitionTo(targetState):
	var stateToChangeTo = targetState; # using animations to set this correctly. ie: lastState as a string
	if(targetState == 'lastState'): #this handles cases where we want to transition back to jump
		stateToChangeTo = lastState;
		if(stateToChangeTo == 'jump'): 
			stateToChangeTo = 'falling';
	lastState = state.name;
	if !has_node(stateToChangeTo): 
		return;
	state.exit();
	state = get_node(stateToChangeTo);
	state.enter(myBody, anim);
	emit_signal("trasitioned", state.name);
