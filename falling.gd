extends Node

var stateMachine = null;
var myAnim;
var myBody;
var speed = 0;
var speedGain = 3;

func enter(body, animator): 
	myBody = body;
	myAnim = animator;
	myAnim.play('jump');
	speed = stateMachine.getVelocityX();
	
func exit(): 
	pass

func update(delta):
	stateMachine.fallCoyote = 0;
	if Input.is_action_pressed('right') && Input.is_action_pressed('left'):
		# this conditional checks to make sure we aren't holding two keys at the same time.
		pass
	else:
		if Input.is_action_just_pressed('action'):
			stateMachine.transitionTo('attack')
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
	if myBody.is_on_floor(): 
		stateMachine.transitionTo('idle');
		
	if Input.is_action_just_released('right') || Input.is_action_just_released('left'):
		speed = 0;

