class_name SpeedBuff
extends BaseBuff

@export var speed_increase := 50.0

func apply_player_upgrade(player: CharacterBody2D):
	player.speed += speed_increase
