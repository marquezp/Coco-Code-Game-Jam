extends Node2D

const ENEMY_SPAWNER = preload("res://Utilities/enemy_spawner.tscn")
const PLAYER = preload("res://Player/player.tscn")
@onready var shop: CanvasLayer = $UI/Shop

func _ready():
	# Instantiate the dependancies
	var enemy_spawner = ENEMY_SPAWNER.instantiate()
	add_child(enemy_spawner)
	var player = PLAYER.instantiate()
	player.global_position = Vector2(400,400)
	add_child(player)
	
	# Give the Managers their dependancies
	ShopManager.get_shop(shop)
	PlayerManager.get_player(player)
	WaveManager.get_spawner(enemy_spawner)
	# Start the waves
	WaveManager.start_next_wave()

	
