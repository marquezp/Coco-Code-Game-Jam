extends Control
@onready var timer: Timer = $Timer
@onready var label_1: Label = $TextureRect/Label1
@onready var label_2: Label = $TextureRect/Label2
@onready var button: Button = $TextureRect/Button

func _ready():
	timer.timeout.connect(next_slide)
	label_1.visible = true
	label_2.visible = false
	button.visible = false
	button.pressed.connect(on_button_press)

func next_slide() -> void:
	if label_2.visible:
		button.visible = true
		return
	label_1.visible = false
	label_2.visible = true
	
func on_button_press()-> void:
	get_tree().change_scene_to_file("res://game.tscn")
	
