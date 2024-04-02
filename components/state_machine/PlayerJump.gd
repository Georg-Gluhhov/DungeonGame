extends MyState
class_name PlayerJump

@export var player: CharacterBody3D
@export var jump_time = 2;

func enter():
	jump_time = 2;

func physics_update(delta: float):
	player.input_move = player.velocity_move(delta, 6)	
	if round(abs(jump_time)) > 0:
		player.gravity_local =  Vector3.UP * player.JUMP_VELOCITY 
		jump_time-=delta*10
	print(jump_time)

	if player.get_input_direction() != Vector3.ZERO  and  round(jump_time)== 0 and player.is_on_floor():
		state_transitioned.emit(self, "moving")
	if player.get_input_direction() == Vector3.ZERO and round(jump_time)== 0 and player.is_on_floor():
		state_transitioned.emit(self,"idle")
	if  !player.is_on_floor() and Input.is_action_just_released("ui_accept") or round(jump_time)== 0:
		state_transitioned.emit(self,"air")
