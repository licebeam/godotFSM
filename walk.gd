extends Node

var stateMachine = null;
var myBody = null;

func enter(body): 
	myBody = body;
	print('in state walk');
	
func exit(): 
	print('leaving state');

func update(delta):
	if Input.is_action_pressed('up'):
		myBody.move_and_slide(Vector2(0, -100));
	elif Input.is_action_pressed('down'):
		myBody.move_and_slide(Vector2(0, 100));
	else: 
		stateMachine.transitionTo('idle');
