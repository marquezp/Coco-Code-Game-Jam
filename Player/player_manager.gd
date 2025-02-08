extends Node

const BUFFS_TAB_DATA = preload("res://UI/BuffsTab/player_buffs_tab.tres")

var player: CharacterBody2D

# Signals
signal health_depleted
signal update_buff_ui
signal player_ready

func get_player(player_instance: CharacterBody2D) -> void:
	player = player_instance
	player_ready.emit()
	
func set_input_allowed(value: bool) -> void:
	player.input_allowed = value

func is_burn_on() -> bool:
	return player.burn_on
	
func get_blood() -> int:
	return player.blood

func get_burn_damage() -> float:
	return player.burn
	
func update_blood(blood_amount: int) -> void:
	player.blood += blood_amount
	print("Blood: ", player.blood)

func update_max_health(new_amount: float) -> void:
	player.max_health += new_amount
	player.max_health_changed()
	
func update_health(health_amount: float) -> void:
	player.health = clamp(player.health,player.health + health_amount, 101)
	
func update_health_regen(regen_change: float)-> void:
	player.health_regen += regen_change
	print("Health Regen: ", player.health_regen)

func scale_damage(value: float):
	player.damage *= value

func update_damage(damage_change: float) -> void:
	player.damage += damage_change
	print("Damage: ", player.damage)

func update_damage_taken(damage_taken_change: float) -> void:
	player.damage_taken += damage_taken_change
	print("Damage Taken: ", player.damage_taken)

func update_attack_speed(attack_speed_change: float) -> void:
	player.attack_speed += attack_speed_change
	print("Damage Taken: ", player.attack_speed)
	
func update_speed(speed_change: float) -> void:
	player.speed += speed_change
	print("Speed: ", player.speed)

func update_burn(burn_change: float):
	player.burn_on = true
	player.burn += burn_change
	print("Burn Damage: ", player.burn)
	
func add_buffs(item_data) -> bool:
	# Use the item's effect
	item_data.use()
	if item_data.name in ["Blood","Health"]: # Put non poisons here
		return true
	if BUFFS_TAB_DATA.add_item(item_data):
		update_buff_ui.emit()
		return true
	return false

func remove_buffs() -> void: 
	for i in range(BUFFS_TAB_DATA.slots.size()):
		BUFFS_TAB_DATA.remove_item(i)
	update_buff_ui.emit()
	reset_player_stats(false)
	
func reset_player_stats(heal: bool = true) -> void:
	player.damage = player.base_damage
	player.burn_on = false
	if heal:
		player.health = player.base_max_health
	player.max_health = player.base_max_health
	player.speed = player.base_speed
	player.health_regen = player.base_health_regen
	player.damage_taken = player.base_damage_taken
	player.max_health_changed()
