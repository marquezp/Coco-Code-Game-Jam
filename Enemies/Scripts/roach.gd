class_name Roach extends BaseEnemy

@onready var special_attack_timer: Timer = $SpecialAttackTimer


func _ready():
	special_attack_timer.timeout.connect(special_attack)

func special_attack():
	if randf() < 0.5:
		data.speed += 200
