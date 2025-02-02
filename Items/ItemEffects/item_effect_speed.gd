class_name ItemEffectSpeed extends ItemEffect

@export var speed_amount : float = 400.0
@export var sound: AudioStream = null

func use() -> void:
	PlayerManager.update_speed(speed_amount)
	if sound:
		sound.play()
