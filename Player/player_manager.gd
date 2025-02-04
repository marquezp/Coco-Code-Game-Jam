extends Node

const BUFFS_TAB_DATA = preload("res://UI/BuffsTab/player_buffs_tab.tres")

@onready var player = get_node("/root/Game/Player")

signal update_buff_ui

func set_input_allowed(value: bool) -> void:
	player.input_allowed = value

func get_blood() -> int:
	return player.blood
	
func update_blood(blood_amount) -> void:
	player.blood += blood_amount
	print("Blood: ", player.blood)
	
func update_damage(damage_change) -> void:
	player.damage += damage_change
	print("Damage: ", player.damage)
	
func update_speed(speed_change) -> void:
	player.speed += speed_change
	print("Speed: ", player.speed)

func add_buffs(item_data) -> bool:
	if item_data.name == "Blood": # Treating this differently than other items
		return true
	if BUFFS_TAB_DATA.add_item(item_data):
		# Use the item's effect
		item_data.use()
		update_buff_ui.emit()
		return true
	return false

func remove_buffs() -> void: 
	for i in range(BUFFS_TAB_DATA.slots.size()):
		BUFFS_TAB_DATA.remove_item(i)
	update_buff_ui.emit()
	reset_player_stats()
	
func reset_player_stats() -> void:
	player.damage = player.base_damage
	player.health = player.base_health
	player.speed = player.base_speed
	player.health_regen = player.base_health_regen
	player.damage_taken = player.base_damage_taken
