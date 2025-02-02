class_name BaseProjectileBuff
extends Resource

########################################
# This is the base projectile class
# that all projectiles will inherit from
########################################
@export var texture: Texture2D = preload("res://Assets/carrot.png")
@export var upgrade_text: String = "Damage"

func apply_upgrade(projectile: Projectile):
	# Does nothing by default
	pass
