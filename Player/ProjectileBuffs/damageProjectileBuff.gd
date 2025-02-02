class_name DamageProjectileBuff
extends BaseBuff

@export var damage_increase := 2.0

func apply_projectile_upgrade(projectile: Projectile):
	projectile.damage += damage_increase
