extends CharacterBody3D
class_name  Player
var head_mov = 0.0
var gravity_local= Vector3()
const  SPEED =10
const JUMP_VELOCITY = 6
@onready var look_pivot: Node3D = $CameraPivot
@onready var pause: Control = %Pause

var input_move: Vector3 = Vector3()



@export var mouse_sensitivity: float = 0.5
@onready var camera:Camera3D = $CameraPivot/Camera3D
const  GRAVITY: int = 40

func _input(event):
	if Input.is_action_just_pressed("menu"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pause.visible = true
		get_tree().paused = true
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-1 * event.relative.x * mouse_sensitivity))
		look_pivot.rotate_x(deg_to_rad(-1 * event.relative.y * mouse_sensitivity))
		look_pivot.rotation.x = clamp(look_pivot.rotation.x, deg_to_rad(-90), deg_to_rad(90))
		look_pivot.rotation.z = clamp(look_pivot.rotation.z, deg_to_rad(-0), deg_to_rad(0))

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	set_velocity(input_move + gravity_local)
	move_and_slide()
	if !is_on_floor():
		gravity_local += GRAVITY * Vector3.DOWN  * delta
	else:
		gravity_local = Vector3.DOWN
	head_mov += delta * velocity.length() * float(is_on_floor())
	look_pivot.transform.origin = _head_move(head_mov) + Vector3(0,1,0)


func _head_move(time) -> Vector3:
	var i = Vector3.ZERO
	i.y = sin(time* 1.7) * 0.07
	i.x = sin(time* 0.75) * 0.05
	return i



func velocity_move(delta, acl):
	return input_move.lerp(get_input_direction()  * SPEED + get_platform_velocity(), delta * acl) 

func get_input_direction() -> Vector3: 
	var z: float =(
		Input.get_action_strength("move_backwards") - Input.get_action_strength("move_forward")
	)
	var x: float =(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	)
	return transform.basis * (Vector3(x,0,z).normalized())



func _on_audio_stream_player_finished():
	$AudioStreamPlayer.play()
