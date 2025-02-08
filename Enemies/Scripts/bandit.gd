class_name Bandit extends BaseEnemy

const BANDIT_PROJECTILE = preload("res://Enemies/bandit_projectile.tscn")
@onready var special_attack_timer: Timer = $SpecialAttackTimer
@onready var firing_point1: Marker2D = $Sprite2D/Pivot/FiringPoint1
@onready var pivot: Marker2D = $Sprite2D/Pivot

func _ready():
	special_attack_timer.timeout.connect(special_attack)
	burn_timer.timeout.connect(apply_burn)
	add_to_group("enemy")
	
func special_attack():
	pivot.look_at((PlayerManager.player.global_position))
	var new_projectile: Projectile = BANDIT_PROJECTILE.instantiate()
	new_projectile.damage = data.projectile_damage
	new_projectile.speed = 500
	new_projectile.global_position = firing_point1.global_position
	new_projectile.rotation = (position.angle_to_point(PlayerManager.player.global_position))
	get_parent().add_child(new_projectile)
