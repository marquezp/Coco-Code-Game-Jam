class_name Player extends CharacterBody2D

const PROJECTILE = preload("res://Player/projectile.tscn")

# Base (starting) Player Attributes
@export var base_damage: float = 1.0
@export var base_damage_taken: float = 10.0
@export var base_speed: float = 400.0
@export var base_health_regen: float = 0.0
@export var base_health: float = 100.0

# Current player attributes
@export var damage: float = base_damage
@export var damage_taken: float = base_damage_taken
@export var speed: float = base_speed
@export var health_regen: float = base_health_regen
@export var health: float = base_health

# Blood (currency for shop)
@export var blood : int = 50
@onready var blood_label: Label = $BloodLabel

var input_allowed: bool = true

# Signals
signal health_depleted

func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	if input_allowed:
		var input_vector = Input.get_vector("left", "right", "up", "down")
		velocity = input_vector.normalized() * speed
		move_and_slide()
	
	# Enemy hitbox detection
	var overlapping_enemies = %PlayerHurtBox.get_overlapping_bodies()
	if overlapping_enemies.size() > 0:
		health -= damage_taken * overlapping_enemies.size() * delta
		%Healthbar.value = health
		if health <= 0:
			health_depleted.emit()
			
	blood_label.text = "Blood: " + str(blood)

func _input(event):
	if input_allowed:
		# Shooting projectiles
		if event.is_action_pressed("shoot"):
			var new_projectile = PROJECTILE.instantiate()
			new_projectile.damage = damage
			new_projectile.position = position
			new_projectile.rotation = (position.angle_to_point(get_global_mouse_position()))
			get_parent().add_child(new_projectile)
