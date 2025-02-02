class_name DamageProjectileBuff
extends BaseProjectileBuff

@export var damage_increase := 2.0

func apply_upgrade(projectile: Projectile):
	projectile.damage += damage_increase
