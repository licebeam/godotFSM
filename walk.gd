extends Node

var stateMachine = null;
var myBody = null;
var speed = 0;
var speedGain = 3;

func enter(body, anim): 
	myBody = body;
	anim.play('walk')
	speed = 0;
	
func exit(): 
	pass

func update(delta):
	if Input.is_action_pressed('right') && Input.is_action_pressed('left'):
		# this conditional checks to make sure we aren't holding two keys at the same time.
		stateMachine.transitionTo('idle');
	else:
		if Input.is_action_just_pressed('up'):
			stateMachine.transitionTo('jump')
		if Input.is_action_pressed('right'):
			speed += speedGain;
			get_node('../../Sprite').set_flip_h(false);
			if speed <= stateMachine.maxSpeed: 
				stateMachine.velocity.x = speed;
		elif Input.is_action_pressed('left'):
			speed += speedGain;
			get_node('../../Sprite').set_flip_h(true);
			if speed <= stateMachine.maxSpeed: 
				stateMachine.velocity.x = -speed;
		else: 
			stateMachine.transitionTo('idle');
		

		if Input.is_action_just_released('right') || Input.is_action_just_released('left'):
			speed = 0;
			
		if Input.is_action_pressed('down'):
			stateMachine.transitionTo('crouch');
