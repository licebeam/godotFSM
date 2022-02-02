extends Node

var stateMachine = null;
var myAnim;
var myBody;
var myHitBox;
var preJump = 3;
var jumpFrames = 30;

var vector = Vector2();
func enter(body, animator): 
	myBody = body;
	myAnim = animator;
	myAnim.play('idle');
	preJump = 3;
	jumpFrames = 30;
	#myBody.move_and_slide(Vector2(0, 200))
	stateMachine.velocity.y = stateMachine.jumpVelocity;
	
func exit(): 
	pass

func update(delta):
	if Input.is_action_pressed('right'):
		get_node('../../Sprite').set_flip_h(false);
		stateMachine.velocity.x = 30;
	elif Input.is_action_pressed('left'):
		get_node('../../Sprite').set_flip_h(true);
		stateMachine.velocity.x = -30;
	if myBody.is_on_floor(): 
		stateMachine.transitionTo('idle');
	pass 

