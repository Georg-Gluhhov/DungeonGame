extends Node3D


@onready var anim = $Character_Animations/AnimationPlayer
@onready var player = %Player3D
@onready var sound = $AudioStreamPlayer3D
@onready var map_RID:RID = get_world_3d().get_navigation_map()
@onready var nav_mesh = get_parent().get_node("NavigationRegion3D")
var collision 
var path_points_packed:PackedVector3Array
var pathing:bool = false
var pathing_point:int = 0 

func enemy_new_path() -> void:
	var safe_goal: Vector3 = NavigationServer3D.map_get_closest_point(map_RID, player.global_position)
	path_points_packed  = NavigationServer3D.map_get_path(map_RID,global_position,safe_goal,true)
	pathing = true
	anim.play("Walk")
	look_at(player.global_position, Vector3.UP)
	pathing_point = 0 
func _physics_process(delta):
	# Get the world's direct space state
	
	# Define the raycast parameters

	# Perform the raycast
	# Check if the ray hit the player
	if pathing:
		var path_next_point: Vector3 = path_points_packed[pathing_point] - global_position
		if path_next_point.length_squared() > 1.0:
			var unit_velocity:Vector3 = (path_next_point.normalized() * delta  *5)
			global_position += unit_velocity 
		else:
			if pathing_point < (path_points_packed.size() - 1):
				pathing_point += 1
				_physics_process(delta)
	

	var from = $RayPivot.global_transform.origin # Start point is the object's position
	var to = player.global_transform.origin # End point is the player's position
	var rayend= PhysicsRayQueryParameters3D.create(from, to)
	collision = get_world_3d().direct_space_state.intersect_ray(rayend)



func _process(delta):
	if collision and collision.collider == player:
		enemy_new_path()

	else: 
		anim.play("Idle")
		pathing = false




func _on_area_3d_body_entered(body):
	if body is Player and pathing:
		if !sound.playing:
			sound.play()
		enemy_new_path()


func _on_attack_body_entered(body):
	if body is Player:
		GameManager.lose()
