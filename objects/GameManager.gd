extends Node
static var key_taken: bool = false 
# Called every frame. 'delta' is the elapsed time since the previous frame.
static func _key_taken():
	key_taken = true
	PlayerLabel.new_text = "Find a blue door"
	
func game_end():
	if key_taken == true:
		get_tree().change_scene_to_file("res://Ui/win.tscn")
func lose():
		get_tree().change_scene_to_file("res://Ui/lose.tscn")
