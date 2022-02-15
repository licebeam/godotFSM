extends Node

var stateMachine = null;
var myAnim;
var myBody;
var myHitBox;

func enter(body, animator): 
	myBody = body;
	myAnim = animator;
	myAnim.play('attack');
	if(myBody.is_on_floor()):
		stateMachine.velocity.x = 0;
	if(stateMachine.velocity.y <= -1):
		stateMachine.velocity.y = 0

func playSwing():
	get_node('../../playerWeapon/anim').play('swing')

func exit(): 
	pass

func update(delta):
	if(myBody.is_on_floor()):
		stateMachine.velocity.x = 0;
	pass

