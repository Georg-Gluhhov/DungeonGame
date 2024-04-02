extends Node

@export var init_state: MyState

var current_state: MyState
var states: Dictionary = {}


func _ready():
	for child_state in get_children():
		if child_state is MyState:
			states[child_state.name.to_lower()] = child_state
			child_state.state_transitioned.connect(on_child_transition)
		if init_state:
			init_state.enter()
			current_state = init_state

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return

	var new_state = states.get(new_state_name.to_lower())

	if !new_state:
		return

	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state
	
