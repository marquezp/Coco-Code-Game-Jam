class_name BaseBuff
extends Resource

########################################
# This is the base projectile class
# that all projectiles will inherit from
########################################
@export var texture: Texture2D = preload("res://Assets/icon.svg")
@export var upgrade_text: String = "Nothing"

func apply_projectile_upgrade(projectile: Projectile):
	# Does nothing by default
	print("I'm doing nothing")

func apply_player_upgrade(player: CharacterBody2D):
	# Does nothing by default
	pass
