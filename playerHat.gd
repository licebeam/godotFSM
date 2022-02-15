extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var sprite;
var playerSprite;
# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("Sprite")
	playerSprite = get_node("../Sprite");
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	sprite.set_flip_h(playerSprite.flip_h)
#	pass
