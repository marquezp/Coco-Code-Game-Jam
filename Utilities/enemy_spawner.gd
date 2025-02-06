extends Node2D

# ADD ALL ENEMY PRELOADS HERE
const ROACH = preload("res://Enemies/roach.tscn")
const RAT = preload("res://Enemies/rat.tscn")
const BANDIT = preload("res://Enemies/bandit.tscn")
const BOSS = preload("res://Enemies/boss.tscn")

var time: int = 0
var timer: Timer
var spawn_info: SpawnInfo

# Sets up a new timer and passes spawn_info to this script
func begin(wave_info: SpawnInfo):
	spawn_info = wave_info
	timer = Timer.new()
	timer.timeout.connect(spawn)
	timer.wait_time = spawn_info.spawn_delay
	add_child(timer)
	timer.start()
	
func spawn():
	if time < spawn_info.total_time:
		time += timer.wait_time
		var enemy_num : int = spawn_info.enemy_list.pick_random()
		var enemy = null
		# Checks all possible enemies
		match enemy_num:
			1:
				enemy = ROACH
			2:
				enemy = RAT
				print("RAT")
			3:
				enemy = BANDIT
				print("BANDIT")
			4:
				enemy = BOSS
				print("BOSS")
		if enemy:
			# Adds as many enemies as spawn_num wants
			for i in range(spawn_info.spawn_num):
				var enemy_spawn = enemy.instantiate()
				enemy_spawn.global_position = get_random_position()
				add_child(enemy_spawn)
	else:
		timer.timeout.disconnect(spawn)
		timer.stop()
		time = 0
		
func get_random_position() -> Vector2:
	%PathFollow2D.progress_ratio = randf()
	return %PathFollow2D.global_position
