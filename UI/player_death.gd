extends CanvasLayer

@onready var button: Button = $Button
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const MAIN_MENU = "res://UI/main_menu.tscn"
@onready var wave_number: Label = $WaveNumber

func _ready():
	button.pressed.connect(_on_button_pressed)
	visible = false
	PlayerManager.health_depleted.connect(_on_player_death)
	
func _on_player_death():
	wave_number.text += str(WaveManager.current_wave_index) + "/5"
	get_tree().paused = true
	visible = true
	animation_player.play("blur")
	
func _on_button_pressed():
	PlayerManager.remove_buffs()
	PlayerManager.reset_player_stats()
	WaveManager.current_wave_index = 0
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_MENU)
	animation_player.play_backwards("blur")
	visible = false
