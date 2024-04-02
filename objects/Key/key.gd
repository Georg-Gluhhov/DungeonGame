extends Node3D
class_name  Keyf


func _ready():
	$AnimationPlayer.play("new_animation")
	GameManager.key_taken = false

func _on_area_3d_body_entered(body):
	if body is Player:
		GameManager._key_taken()
		queue_free()
