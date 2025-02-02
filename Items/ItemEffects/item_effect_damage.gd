class_name ItemEffectDamage extends ItemEffect

@export var damage_amount : int = 1
@export var sound: AudioStream = null

func use() -> void:
	PlayerManager.update_damage(damage_amount)
	if sound:
		sound.play()
