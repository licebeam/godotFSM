extends Node

var stateMachine = null;

func enter(body, animator): 
	stateMachine.velocity.x = 0;
	animator.play('idle')
	
func exit(): 
	pass

func update(delta):
	if Input.is_action_just_pressed('up'):
		stateMachine.transitionTo('jump')
	if Input.is_action_pressed('down'):
		stateMachine.transitionTo('crouch');
	if Input.is_action_pressed('left') || Input.is_action_pressed('right'):
		stateMachine.transitionTo('walk');
	pass
