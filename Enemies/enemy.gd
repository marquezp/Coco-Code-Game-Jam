extends CharacterBody2D

@export var health = 3

@export var speed = 200.0
@onready var player: CharacterBody2D = $"../Player"

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

func take_damage(damage):
	health -= damage
	if health <= 0:
		queue_free()
