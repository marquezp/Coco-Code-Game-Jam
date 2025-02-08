class_name ItemEffectSpeed extends ItemEffect

@export var regen_amount: float = -0.3
@export var speed_amount : float = 30.0
@export var sound: AudioStream = null


func use() -> void:
	PlayerManager.update_speed(speed_amount)
	PlayerManager.update_health_regen(regen_amount)
	if sound:
		sound.play()
