extends MyState
class_name PlayerMoving

@export var player: CharacterBody3D

func physics_update(delta: float):
	player.input_move = player.velocity_move(delta, 13)

	if player.get_input_direction() == Vector3.ZERO:
		state_transitioned.emit(self,"idle")
	if Input.is_action_just_pressed("ui_accept") and player.is_on_floor():
		state_transitioned.emit(self, "jump")
	
