extends Node

var stateMachine = null;

func enter(body, animator): 
	animator.play('hurt')

func exit(): 
	pass

func update(delta):
	if(stateMachine.velocity.x > 0):
		stateMachine.velocity.x -= stateMachine.velocity.x / stateMachine.slideStop;
	if(stateMachine.velocity.x < 0): 
		stateMachine.velocity.x -= stateMachine.velocity.x / stateMachine.slideStop;
	
	pass
