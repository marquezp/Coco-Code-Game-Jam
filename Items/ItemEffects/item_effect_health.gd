class_name ItemEffectHealth extends ItemEffect

@export var health_amount : float = 20.0
@export var sound : AudioStream = null

func use() -> void:
	PlayerManager.update_health(health_amount)
	if sound:
		sound.play()
