class_name ItemEffectBlood extends ItemEffect

@export var blood_amount : float = 1.0
@export var sound : AudioStream = null

func use() -> void:
	PlayerManager.update_blood(blood_amount)
	if sound:
		sound.play()
