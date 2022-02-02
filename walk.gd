extends Node

var stateMachine = null;
var myBody = null;

func enter(body, anim): 
	myBody = body;
	anim.play('walk')
	
func exit(): 
	pass

func update(delta):
	if Input.is_action_just_pressed('up'):
		stateMachine.transitionTo('jump')
	if Input.is_action_pressed('right'):
		get_node('../../Sprite').set_flip_h(false);
		stateMachine.velocity.x = 30;
	elif Input.is_action_pressed('left'):
		get_node('../../Sprite').set_flip_h(true);
		stateMachine.velocity.x = -30;
	else: 
		stateMachine.transitionTo('idle');
	
	if Input.is_action_pressed('down'):
		stateMachine.transitionTo('crouch');
