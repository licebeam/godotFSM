extends Node

signal trasitioned(stateName);

export(NodePath) var initial_state;
export(NodePath) var body;
export(NodePath) var animator;
export(NodePath) var sprite;
export(NodePath) var kbody;

export (PackedScene) var smokePuffScene
export (PackedScene) var hitSparkScene
export (PackedScene) var fireExplodeScene

export(NodePath) var area2d;
onready var collider = get_node(area2d);

var hurt = false;
var health = 1000;

onready var myBody = get_node(body);
onready var kinematic = get_node(kbody);
onready var anim = get_node(animator);
onready var state = get_node(initial_state);
onready var mySprite = get_node(sprite);

#shader
onready var hitShader = preload("res://whiteFlash.tres")

var lastState = 'idle';
#handle movement
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

#script extension vars
var knockBackDisabled = false;
var gravityDisabled = false;
var screenShakeDisabled = false;

func getGravity():
	return jumpGravity if velocity.y < 0.0 else fallGravity;
# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		child.stateMachine = self;
	state.enter(myBody, anim);

func destroySelf():
	var camera = get_node('/root/World/Player/body/mainCamera')
	if(!screenShakeDisabled):
		camera.isShaking = true;
	spawnFireExplode()
	myBody.queue_free();
	
func knockBack():
	if(!knockBackDisabled):
		spawnDust()
		var playerBody = get_node('/root/World/Player/body')
		if playerBody.global_position.x > kinematic.global_position.x:
			velocity.x = -8
		if playerBody.global_position.x < kinematic.global_position.x:
			velocity.x = 8
		
func spawnDust():
	# generate smoke puff.
	var location = get_node('/root/World/')
	var puff = smokePuffScene.instance()
	location.add_child(puff)
	puff.setPosition(kinematic.global_position)

func spawnHitSpark():
	var location = get_node('/root/World/')
	var puff = hitSparkScene.instance()
	location.add_child(puff)
	puff.setPosition(kinematic.global_position)

func spawnFireExplode():
	# generate smoke puff.
	var location = get_node('/root/World/')
	var puff = fireExplodeScene.instance()
	var puff1 = fireExplodeScene.instance()
	var puff2 = fireExplodeScene.instance()
	location.add_child(puff)
	puff.setPosition(kinematic.global_position)
	location.add_child(puff1)
	puff1.setPosition(kinematic.global_position)
	location.add_child(puff2)
	puff2.setPosition(kinematic.global_position)

func setNotHurt():
	transitionTo('idle')
	hurt = false;
	mySprite.material.shader = null;

func setHitShader():
	mySprite.material.shader = hitShader;

func turnOffHitShader():
	mySprite.material.shader = null;

func _physics_process(delta):
	if !gravityDisabled: 
		if kinematic.is_on_floor():
			velocity.y = 0
		else:
			velocity.y += getGravity() * delta;
		kinematic.move_and_slide(velocity, Vector2.UP);
			
func _process(delta):
	myBody = get_node(body);
	state.update(delta);
	
	if(health <= 0):
		destroySelf();
		
	var overlaps = collider.get_overlapping_areas()
	if(overlaps.size() >= 1 && !hurt):
		for over in overlaps:
			if(over.name == 'slashArea'):
				transitionTo('hurt')
				hurt = true;
				health -= 1;
				spawnHitSpark()

func transitionTo(targetState):
	var stateToChangeTo = targetState; # using animations to set this correctly. ie: lastState as a string
	if(targetState == 'lastState'): #this handles cases where we want to transition back to jump
		stateToChangeTo = lastState;
	lastState = state.name;
	if !has_node(stateToChangeTo): 
		return;
	state.exit();
	state = get_node(stateToChangeTo);
	state.enter(myBody, anim);
	emit_signal("trasitioned", state.name);
