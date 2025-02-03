class_name Player extends CharacterBody2D

const PROJECTILE = preload("res://Player/projectile.tscn")
const BUFF_TAB_DATA: BuffTabData = preload("res://UI/player_buffs_tab.tres")

# Player attributes
@export var damage: float = 1.0
@export var damage_taken: float = 10.0
@export var speed: float = 400.0
@export var health_regen: float = 0.0
@export var health: float = 50.0

# Blood (currency for shop)
@export var blood : int = 0

# Signals
signal health_depleted

func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	var input_vector = Input.get_vector("left", "right", "up", "down")
	velocity = input_vector.normalized() * speed
	move_and_slide()
	
	# Enemy hitbox detection
	var overlapping_enemies = %HurtBox.get_overlapping_bodies()
	if overlapping_enemies.size() > 0:
		health -= damage_taken * overlapping_enemies.size() * delta
		%Healthbar.value = health
		if health <= 0:
			health_depleted.emit()

func _input(event):
	# Shooting projectiles
	if event.is_action_pressed("shoot"):
		var new_projectile = PROJECTILE.instantiate()
		new_projectile.damage = damage
		new_projectile.position = position
		new_projectile.rotation = (position.angle_to_point(get_global_mouse_position()))
		get_parent().add_child(new_projectile)
