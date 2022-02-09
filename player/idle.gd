extends Node

var stateMachine = null;

func enter(body, animator): 
	animator.play('idle')

func exit(): 
	pass

func update(delta):
	if(stateMachine.velocity.x > 0):
		stateMachine.velocity.x -= stateMachine.velocity.x / stateMachine.slideStop;
	if(stateMachine.velocity.x < 0): 
		stateMachine.velocity.x -= stateMachine.velocity.x / stateMachine.slideStop;
		
	if Input.is_action_just_pressed('action'):
		stateMachine.transitionTo('attack')
	if Input.is_action_just_pressed('up'):
		stateMachine.transitionTo('jump')
	if Input.is_action_pressed('down'):
		stateMachine.transitionTo('crouch');
	if Input.is_action_pressed('left') || Input.is_action_pressed('right'):
		stateMachine.transitionTo('walk');
	pass
