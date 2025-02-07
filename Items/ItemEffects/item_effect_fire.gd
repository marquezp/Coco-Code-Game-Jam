class_name ItemEffectFire extends ItemEffect

@export var burn_damage : float = 2.0
@export var sound : AudioStream = null

func use() -> void:
	PlayerManager.update_burn(burn_damage)
	if sound:
		sound.play()
