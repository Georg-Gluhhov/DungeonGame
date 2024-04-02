extends Control

@onready var audio = $AudioStreamPlayer3D
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	audio.play()

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Ui/main_menu.tscn")
