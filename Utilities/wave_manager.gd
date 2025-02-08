extends Node

# ADD ALL WAVE PRELOADS HERE
const WAVE1 = preload("res://Enemies/Waves/wave1.tres")
const WAVE2 = preload("res://Enemies/Waves/wave2.tres")
const WAVE3 = preload("res://Enemies/Waves/wave3.tres")
const WAVE4 = preload("res://Enemies/Waves/wave4.tres")
const WAVE5 = preload("res://Enemies/Waves/wave5.tres")

# Iterate through this array when calling next wave
const WAVES : Array[SpawnInfo] = [WAVE1,WAVE2,WAVE3,WAVE4,WAVE5]

var enemy_spawner: Node2D
var current_wave_index: int = 0
var current_wave : SpawnInfo = WAVES[current_wave_index]

func update_enemy_deaths():
	# spawn should be done spawning (maybe use signal to make sure)
	if enemy_spawner.time >= current_wave.total_time:
		if get_tree().get_nodes_in_group("enemy").size() <= 1:
			wave_over()

func get_spawner(spawner: Node2D) -> void:
	enemy_spawner = spawner
	
func start_next_wave():
	print("Wave ",current_wave_index)
	enemy_spawner.begin(current_wave)

func wave_over():
	current_wave_index += 1
	if current_wave_index >= 5:
		print("we got to index = 5")
		get_tree().change_scene_to_file("res://UI/game_end.tscn")
	else:
		current_wave = WAVES[current_wave_index]
		ShopManager.spawn_shop()
	
