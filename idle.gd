extends Node

var stateMachine = null;

func enter(body): 
	print('in state idle');
	
func exit(): 
	print('leaving state idle');

func update(delta):
	if Input.is_action_just_pressed('up') || Input.is_action_just_pressed('down'):
		stateMachine.transitionTo('walk');
	pass
