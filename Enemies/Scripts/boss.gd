class_name Boss extends BaseEnemy

const BOSS_PROJECTILE = preload("res://Enemies/boss_projectile.tscn")
@onready var special_attack_timer: Timer = $SpecialAttackTimer
@onready var firing_point: Marker2D = $Sprite2D/Pivot/FiringPoint
@onready var pivot: Marker2D = $Sprite2D/Pivot


func _ready():
	special_attack_timer.timeout.connect(special_attack)
	burn_timer.timeout.connect(apply_burn)
	add_to_group("enemy")
	
func special_attack():
	# Ranged Attack
	if randf() <= 0.33:
		pivot.look_at((PlayerManager.player.global_position))
		var new_projectile: BossProjectile = BOSS_PROJECTILE.instantiate()
		new_projectile.damage = data.projectile_damage
		new_projectile.speed = 600
		new_projectile.global_position = firing_point.global_position
		new_projectile.rotation = (position.angle_to_point(PlayerManager.player.global_position))
		animation_player.play("throw")
		get_parent().add_child(new_projectile)
	else:
		# Jump towards player
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position",PlayerManager.player.global_position,0.5)
		animation_player.play("jump")
		
		
		
