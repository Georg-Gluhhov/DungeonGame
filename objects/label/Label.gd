extends Label
class_name PlayerLabel
@export var duration = 20.0

@onready var tween = create_tween() 
@export var trans:Tween.TransitionType
@export var ease:Tween.EaseType

static var new_text: String = "Find a key"

var old_char
@onready var player = $AudioStreamPlayer2D

func _ready():
	play()
	
func play():
	tween.set_trans(trans)
	tween.set_ease(ease)
	tween.tween_property(self, "visible_ratio", 1.0, duration)
	await tween.finished
func _process(_delta):
	text = new_text
	if visible_characters != old_char and visible_characters >0:
		old_char = visible_characters
		player.play()

