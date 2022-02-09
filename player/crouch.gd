extends Node

var stateMachine = null;
var myAnim;

func enter(body, animator): 
	myAnim = animator;
	myAnim.play('crouch');
	stateMachine.velocity.x = 0;
	
func exit(): 
	pass
	
func update(delta):
	if Input.is_action_pressed('down'):
		myAnim.play('crouch')
		if Input.is_action_just_pressed('action'):
			stateMachine.transitionTo('crouchAttack')
	else: 
		stateMachine.transitionTo('idle');
	pass
