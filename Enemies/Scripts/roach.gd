class_name Roach extends BaseEnemy

@onready var special_attack_timer: Timer = $SpecialAttackTimer


func _ready():
	special_attack_timer.timeout.connect(special_attack)
	burn_timer.timeout.connect(apply_burn)
	add_to_group("enemy")
	
func special_attack():
	pass
