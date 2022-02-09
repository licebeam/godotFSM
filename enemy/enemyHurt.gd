extends Node

var stateMachine = null;
var myAnim;
var myBody;
var myHitBox;

func enter(body, animator): 
	myBody = body;
	myAnim = animator;
	myAnim.play('hurt');
	stateMachine.knockBack();
	
func exit(): 
	pass

func update(delta):
	pass

