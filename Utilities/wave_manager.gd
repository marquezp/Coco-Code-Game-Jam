extends Node

# ADD ALL WAVE PRELOADS HERE
const WAVE1 = preload("res://Enemies/Waves/wave1.tres")
# Iterate through this array when calling next wave
const WAVES : Array[SpawnInfo] = [WAVE1,WAVE1,WAVE1]

@onready var enemy_spawner = get_node("/root/Game/EnemySpawner")
var current_wave_index: int = 0
var current_wave : SpawnInfo = WAVES[current_wave_index]
var enemies_dead: int = 0 : set = update_enemy_deaths
var enemies_to_kill: int

func _ready():
	# Need to call this from another script (on game start, on finished shopping)
	start_next_wave()

	
func update_enemy_deaths(value):
	enemies_dead = value
	if enemies_dead == enemies_to_kill:
		wave_over()
	
func start_next_wave():
	print("Wave ",current_wave_index)
	enemy_spawner.begin(current_wave)
	enemies_to_kill = (current_wave.total_time * current_wave.spawn_num) / current_wave.spawn_delay
	print("Enemies this round: ", enemies_to_kill)

func wave_over():
	enemies_dead = 0
	current_wave_index += 1
	current_wave = WAVES[current_wave_index]
	ShopManager.spawn_shop()
	
