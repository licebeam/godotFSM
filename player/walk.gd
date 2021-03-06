extends Node

var stateMachine = null;
var myBody = null;
var speed = 0;
var speedGain = 10;

func enter(body, anim): 
	myBody = body;
	anim.play('walk')
	speed = stateMachine.getVelocityX();

func exit(): 
	pass

func update(delta):
	if Input.is_action_just_pressed('action'):
		stateMachine.transitionTo('attack')
	if Input.is_action_just_pressed('up'):
		stateMachine.transitionTo('jump')
	if Input.is_action_pressed('right'):
		speed += speedGain;
		get_node('../../Sprite').set_flip_h(false);
		get_node('../../playerWeapon/Sprite').set_flip_h(false);
		if speed <= stateMachine.maxSpeed: 
			stateMachine.velocity.x = speed;
	elif Input.is_action_pressed('left'):
		speed += speedGain;
		get_node('../../Sprite').set_flip_h(true);
		get_node('../../playerWeapon/Sprite').set_flip_h(true);
		if speed <= stateMachine.maxSpeed: 
			stateMachine.velocity.x = -speed;
	else: 
		stateMachine.transitionTo('idle');
	
	if Input.is_action_just_released('right') || Input.is_action_just_released('left'):
		speed = 0;
		stateMachine.velocity.x = 0;
		stateMachine.transitionTo('idle');
		
	if Input.is_action_pressed('down'):
		speed = 0;
		stateMachine.velocity.x = 0;
		stateMachine.transitionTo('crouch');

