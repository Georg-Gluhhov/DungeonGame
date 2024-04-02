extends MyState
class_name PlayerAir

@export var player: CharacterBody3D


func physics_update(delta: float):
	player.input_move = player.velocity_move(delta, 6)	


	if player.get_input_direction() != Vector3.ZERO  and  player.is_on_floor():
		state_transitioned.emit(self, "moving")
	if player.get_input_direction() == Vector3.ZERO and player.is_on_floor():
		state_transitioned.emit(self,"idle")
	
