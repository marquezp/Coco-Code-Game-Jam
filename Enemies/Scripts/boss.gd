class_name Boss extends BaseEnemy

const PROJECTILE = preload("res://Player/projectile.tscn")
@onready var special_attack_timer: Timer = $SpecialAttackTimer
@onready var firing_point: Marker2D = $Sprite2D/Pivot/FiringPoint
@onready var pivot: Marker2D = $Sprite2D/Pivot
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready():
	special_attack_timer.timeout.connect(special_attack)
	
func special_attack():
	# Ranged Attack
	if randf() < 0.4:
		print("fire")
		pivot.look_at((PlayerManager.player.global_position))
		var new_projectile: Projectile = PROJECTILE.instantiate()
		new_projectile.damage = data.damage
		new_projectile.speed = 400
		new_projectile.global_position = firing_point.global_position
		new_projectile.rotation = (position.angle_to_point(PlayerManager.player.global_position))
		get_parent().add_child(new_projectile)
	else:
		# Jump towards player
		print("jump")
		var tween = get_tree().create_tween()
		tween.tween_property(self,"position",PlayerManager.player.global_position,0.5)
		animation_player.play("jump")
		
		
		
