extends Node

## getPlayer information 
var PlayerInfo = Character.new()

signal trasitioned(stateName);

export(NodePath) var initial_state;
export(NodePath) var body;
export(NodePath) var animator;
export(NodePath) var sprite;
export (PackedScene) var smokePuffScene
export (PackedScene) var basicSlashScene

export(NodePath) var area2d;
onready var collider = get_node(area2d);

onready var myBody = get_node(body);
onready var mySprite = get_node(sprite);
onready var anim = get_node(animator);
onready var state = get_node(initial_state);

var states = {
	"idle": "idle",
	"jump": "jump",
	"falling": "falling",
	"walk": "walk",
	"attack": "attack",
	"hurt": "hurt",
	"crouch": "crouch",
	"laststates": "laststates",
};

#save last state
var laststates = states.idle;

#SPECIAL VARS 
var isOnMoving = false; #when touching a moving platform

#Movement Variables - jump / falling from youtube tutorial.
var velocity = Vector2.ZERO;
export var jumpHeight = 30;
export var jumpTimeToPeak = 0.4;
export var jumpTimeToDescent = 0.3;
export var maxSpeed = 30;
export var maxFallCoyote = 3;
export var slideStop = 6; # 6 frames to stop.
var fallCoyote = maxFallCoyote; #coyote time is used to help players from making mistakes, allows buffer time before falling.

onready var jumpVelocity = ((2.0 * jumpHeight) / jumpTimeToPeak) * -1.0;
onready var jumpGravity = ((-2.0 * jumpHeight) / (jumpTimeToPeak * jumpTimeToPeak)) * -1.0;
onready var fallGravity = ((-2.0 * jumpHeight) / (jumpTimeToDescent * jumpTimeToDescent)) * -1.0;

#shader
onready var hitShader = preload("res://whiteFlash.tres")

#external states 
var hurt = false; # handles taking no damage
var enemyBody = null;
var maxInvulnTimer = 120;
var invulnTimer = 0;

func getGravity():
	return jumpGravity if velocity.y < 0.0 else fallGravity;

func setNothurt():
	transitionTo(states.idle)
	hurt = false;
	invulnTimer = maxInvulnTimer;

func knockBack():
	spawnDust()
	if myBody.global_position.x > enemyBody.global_position.x:
		velocity.y = jumpVelocity;
		velocity.x = 160
	if myBody.global_position.x < enemyBody.global_position.x:
		velocity.y = jumpVelocity;
		velocity.x = -160
		
func setHitShader():
	mySprite.material.shader = hitShader;

func turnOffHitShader():
	mySprite.material.shader = null;
	
func spawnDust():
	# generate smoke puff.
	var location = get_node('/root/World/')
	var puff = smokePuffScene.instance()
	location.add_child(puff)
	puff.setPosition(myBody.global_position)

func spawnSlash(crouch = false):
	# generate blade sprite.
	var slash = basicSlashScene.instance()
	myBody.add_child(slash)
	slash.setPosition(get_node('../Sprite').flip_h, crouch)
	
func _ready():
	for child in get_children():
		child.stateMachine = self;
	state.enter(myBody, anim);

func _physics_process(delta):
	if(fallCoyote >= 1 && ![states.jump, states.hurt].has(state.name)):
		velocity.y = 0;
	else: 
		velocity.y += getGravity() * delta;
	myBody.move_and_slide(velocity, Vector2.UP);
	
	if !myBody.is_on_floor() && ![states.jump, states.attack, states.hurt].has(state.name) && fallCoyote <= 0: #transition to fall if no state active.
		transitionTo(states.falling);
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
	
	#handle hitbox - stuff that makes me take damage
	var overlaps = collider.get_overlapping_areas()
	if(overlaps.size() >= 1):
		for over in overlaps:
			# print(over.name)
			if(over.name == 'spireHitBox' && invulnTimer <= 0):
				transitionTo(states.hurt);
				enemyBody = over.get_parent()
			
	if invulnTimer >= 1: #if we are invulnerable count down. set by animation.
		invulnTimer -= 1;
		mySprite.modulate.a = 0.0 if Engine.get_frames_drawn() % 8 == 0 else 1.0
		if invulnTimer <= 100: #if we are invulnerable count down. set by animation.
			turnOffHitShader();
		if invulnTimer <= 0: #if we are invulnerable count down. set by animation.
			mySprite.modulate.a = 1

func transitionTo(targetstates):
	var stateToChangeTo = targetstates; # using animations to set this correctly. ie: laststates as a string
	if(targetstates == states.laststates): #this handles cases where we want to transition back to a specific animation
		stateToChangeTo = laststates;
		if(stateToChangeTo == states.jump): 
			stateToChangeTo = states.falling;
		if(stateToChangeTo == states.walk): # fixes bug when trasitioning between attack and changing move direction.
			stateToChangeTo = states.idle;
	laststates = state.name;

	if !has_node(stateToChangeTo): 
		return;
	state.exit();
	state = get_node(stateToChangeTo);
	state.enter(myBody, anim);
	emit_signal("trasitioned", state.name);
