extends Control
@onready var play: Button = $MarginContainer/VBoxContainer/Play
@onready var options: Button = $MarginContainer/VBoxContainer/Options
@onready var exit: Button = $MarginContainer/VBoxContainer/Exit

func _ready():
	play.pressed.connect(on_play_pressed)
	options.pressed.connect(on_options_pressed)
	exit.pressed.connect(on_exit_pressed)
	
func on_play_pressed():
	get_tree().change_scene_to_file("res://game.tscn")
	
func on_options_pressed():
	pass

func on_exit_pressed():
	get_tree().quit()
