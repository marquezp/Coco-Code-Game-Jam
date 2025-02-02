extends Node2D

func _ready():
	spawn_enemy()
	spawn_enemy()
	spawn_enemy()

func spawn_enemy():
	var new_enemy = preload("res://Enemies/enemy.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_enemy.global_position = %PathFollow2D.global_position
	add_child(new_enemy)
	
