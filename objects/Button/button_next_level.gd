extends Button
@export var delay = 1.0 
@onready var player = $AudioStreamPlayer

@export_enum("Question_1", "Question_2") var scene_name:String = "Question_1"
func _on_pressed():
	get_tree().change_scene_to_file("res://levels/" + scene_name.to_lower() +".tscn")
func _ready():
	var r = randf_range(1.1, 2.5)
	delay += r 
	await get_tree().create_timer(delay).timeout
	player.play()
	visible = true
	var t = randf_range(0.1, 1.5)
	var tween = create_tween().set_loops().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "rotation", 0.5, t).from_current().set_ease(Tween.EASE_OUT)
	rotation = 0.5
	tween.tween_property(self, "rotation", 0, t).from_current().set_ease(Tween.EASE_IN)
	rotation = 0
	tween.tween_property(self, "rotation", -0.5, randf_range(0.1, 1.5)).from_current().set_ease(Tween.EASE_OUT)
	rotation = -0.5
	tween.tween_property(self, "rotation", 0, t).from_current().set_ease(Tween.EASE_IN)
	rotation = 0
	await tween.loop_finished
	
	
