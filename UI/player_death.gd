extends CanvasLayer

@onready var button: Button = $Button
const MAIN_MENU = "res://UI/main_menu.tscn"

func _ready():
	button.pressed.connect(_on_button_pressed)
	visible = false
	print(PlayerManager.player)
	PlayerManager.health_depleted.connect(_on_player_death)
	
func _on_player_death():
	get_tree().paused = true
	visible = true
	
func _on_button_pressed():
	PlayerManager.remove_buffs()
	PlayerManager.reset_player_stats()
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_MENU)
	visible = false
