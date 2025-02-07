class_name ItemEffectAttspeed extends ItemEffect

@export var attack_speed_change : float = -0.1
@export var damage_scaling : float = 0.8
@export var sound : AudioStream = null

func use() -> void:
	PlayerManager.update_attack_speed(attack_speed_change)
	PlayerManager.scale_damage(damage_scaling)
	if sound:
		sound.play()
