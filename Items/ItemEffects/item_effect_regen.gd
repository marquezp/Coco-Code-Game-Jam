class_name ItemEffectRegen extends ItemEffect

@export var regen_amount : float = 1.0
@export var max_hp_change : float = -20
@export var sound : AudioStream = null

func use() -> void:
	PlayerManager.update_health_regen(regen_amount)
	PlayerManager.update_max_health(max_hp_change)
	if sound:
		sound.play()
