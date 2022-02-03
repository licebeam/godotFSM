extends Node

var stateMachine = null;
var myAnim;
var myBody;
var myHitBox;

var vector = Vector2();

func enter(body, animator): 
	myBody = body;
	myAnim = animator;
	myAnim.play('crouchAttack');
	
func exit(): 
	pass

func update(delta):
	pass 

