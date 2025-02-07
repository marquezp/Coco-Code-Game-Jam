class_name ItemEffectArmor extends ItemEffect

@export var armor_amount : float = -2.0
@export var speed_amount : float = -50
@export var sound : AudioStream = null

func use() -> void:
	PlayerManager.update_damage_taken(armor_amount)
	PlayerManager.update_speed(speed_amount)
	if sound:
		sound.play()
