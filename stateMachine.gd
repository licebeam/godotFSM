extends Node

signal trasitioned(stateName);

export(NodePath) var initial_state;
export(NodePath) var body;

onready var myBody = get_node(body);
onready var state = get_node(initial_state);

func _ready():
	for child in get_children():
		child.stateMachine = self;
	state.enter(myBody);

func _process(delta):
	state.update(delta);

func transitionTo(targetState):
	if !has_node(targetState): 
		return;
	state.exit();
	state = get_node(targetState);
	state.enter(myBody);
	emit_signal("trasitioned", state.name);
