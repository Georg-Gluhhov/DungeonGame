extends Control



func _on_button_pressed():
	unpause()
	get_tree().change_scene_to_file("res://dungeon.tscn")

func _on_button_3_pressed():
	unpause()
	%Pause.visible = false

func _on_button_2_pressed():
	unpause()
	get_tree().change_scene_to_file("res://Ui/main_menu.tscn")

func unpause():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
