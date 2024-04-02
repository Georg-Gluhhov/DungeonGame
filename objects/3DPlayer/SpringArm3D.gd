extends SpringArm3D
@onready var pickup = $Pickup
@onready var interaction = get_parent().get_node("Interaction")
var picked_obj 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	if get_hit_length() <= 1.4 and picked_obj:
		picked_obj.get_node("CollisionShape3D").disabled= true
	if get_hit_length() > 1.4 and picked_obj:
		picked_obj.get_node("CollisionShape3D").disabled= false

	if Input.is_action_just_pressed("pick"):
		if picked_obj:
			_drop_object()
		else:
			_pick_object()

	#if player holds an object 
	if picked_obj != null:
		var a = picked_obj.global_transform.origin
		var b = pickup.global_transform.origin
		picked_obj.set_linear_velocity((b-a)*10)

func _pick_object():
	var collide = interaction.get_collider()
	print(collide)
	if collide and collide is RigidBody3D:
		picked_obj = collide
		add_excluded_object(picked_obj)
		picked_obj.set_collision_layer_value(1, false)
		picked_obj.set_collision_mask_value(1, false)

func _drop_object():
	picked_obj.set_collision_layer_value(1, true)
	picked_obj.set_collision_mask_value(1, true)
	picked_obj.get_node("CollisionShape3D").disabled= false
	picked_obj=null
