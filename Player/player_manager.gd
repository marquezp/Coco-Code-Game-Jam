extends Node

const BUFFS_TAB_DATA = preload("res://UI/BuffsTab/player_buffs_tab.tres")

@onready var player = get_node("/root/Game/Player")

signal update_buff_ui
signal update_shop_ui

func update_blood(blood_amount):
	player.blood += blood_amount
	print("Blood: ", player.blood)
	
func update_damage(damage_change):
	player.damage += damage_change
	print("Damage: ", player.damage)
	
func update_speed(speed_change):
	player.speed += speed_change
	print("Speed: ", player.speed)

func add_buffs(item_data) -> bool:
	if item_data.name == "Blood":
		return true
	if BUFFS_TAB_DATA.add_item(item_data):
		update_buff_ui.emit()
		return true
	return false
		
func _ready() -> void:
	pass
