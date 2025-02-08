extends Control
#Buttons
@onready var play: Button = $MarginContainer/Options/Play
@onready var audio: Button = $MarginContainer/Options/Audio
@onready var exit: Button = $MarginContainer/Options/Exit

@onready var options: VBoxContainer = $MarginContainer/Options

# Audio Settings
@onready var back_button: Button = $AudioSettings/BackButton
@onready var audio_settings: Control = $AudioSettings

func _ready():
	play.pressed.connect(on_play_pressed)
	audio.pressed.connect(on_audio_pressed)
	exit.pressed.connect(on_exit_pressed)
	back_button.pressed.connect(on_back_pressed)
	
func on_play_pressed():
	get_tree().change_scene_to_file("res://UI/intro.tscn")
	
func on_audio_pressed():
	audio_settings.visible = true
	options.visible = false
	
func on_exit_pressed():
	get_tree().quit()

func on_back_pressed():
	audio_settings.visible = false
	options.visible = true
