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

#Movement Variables - jump / falling from youtube tutorial.
var velocity = Vector2.ZERO;
export var jumpHeight = 100;
export var jumpTimeToPeak = 0.5;
export var jumpTimeToDescent = 0.5;

onready var jumpVelocity = ((2.0 * jumpHeight) / jumpTimeToPeak) * -1.0;
onready var jumpGravity = ((-2.0 * jumpHeight) / (jumpTimeToPeak * jumpTimeToPeak)) * -1.0;
onready var fallGravity = ((-2.0 * jumpHeight) / (jumpTimeToDescent * jumpTimeToDescent)) * -1.0;

func getGravity():
	return jumpGravity if velocity.y < 0.0 else fallGravity;
	
func _ready():
	print(PlayerInfo.health)
	for child in get_children():
		child.stateMachine = self;
	state.enter(myBody, anim);

func _physics_process(delta):
	velocity.y += getGravity() * delta;
	myBody.move_and_slide(velocity, Vector2.UP);
	if !myBody.is_on_floor() && !state.name == 'jump': #transition to fall if no state active.
		transitionTo('falling');

func _process(delta):
	myBody = get_node(body);
	state.update(delta);
	
func transitionTo(targetState):
	if !has_node(targetState): 
		return;
	state.exit();
	state = get_node(targetState);
	state.enter(myBody, anim);
	emit_signal("trasitioned", state.name);
