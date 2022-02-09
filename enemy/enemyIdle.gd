extends Node

var stateMachine = null;
var myAnim;
var myBody;
var myHitBox;

func enter(body, animator): 
	myBody = body;
	myAnim = animator;
	myAnim.play('idle');
	stateMachine.velocity.x = 0;
	
func exit(): 
	pass

func update(delta):
	pass

