extends Node

var stateMachine = null;

func enter(body): 
	print('in state');
	
func exit(): 
	print('leaving state');

func update(delta):
	if Input.is_action_just_pressed('up') || Input.is_action_just_pressed('down'):
		stateMachine.transitionTo('walk');
	pass
