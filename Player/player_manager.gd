extends Node

const BUFFS_TAB_DATA = preload("res://UI/player_buffs_tab.tres")

@onready var player = get_node("/root/Game/Player")

signal update_buff_ui

func update_damage(damage_change):
	player.damage += damage_change
	print(player.damage)
	print("here")
	
func update_speed(speed_change):
	player.speed += speed_change
	print(player.speed)
	print("here")

func add_buffs(item_data) -> bool:
	if BUFFS_TAB_DATA.add_item(item_data):
		update_buff_ui.emit()
		return true
	return false
		
func _ready() -> void:
	pass
