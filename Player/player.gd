class_name Player extends CharacterBody2D

const PROJECTILE = preload("res://Player/projectile.tscn")

# Base (starting) Player Attributes
@export var base_damage: float = 1.0
@export var base_damage_taken: float = 10.0
@export var base_speed: float = 400.0
@export var base_health_regen: float = 0.0
@export var base_health: float = 100.0

# Current player attributes
@onready var damage: float = base_damage
@onready var damage_taken: float = base_damage_taken
@onready var speed: float = base_speed
@onready var health_regen: float = base_health_regen
@onready var health: float = base_health

# Blood (currency for shop)
@export var blood : int = 50
@onready var blood_label: Label = $BloodLabel
@onready var bleed_timer: Timer = $BleedTimer
@onready var firing_point: Marker2D = $PlayerSprite/Pivot/FiringPoint
@onready var pivot: Marker2D = $PlayerSprite/Pivot
@onready var sprite: Sprite2D = $PlayerSprite


var input_allowed: bool = true
var is_bleeding: bool = false
var times_bled: int = 0

# Signals
signal health_depleted

func _ready():
	bleed_timer.timeout.connect(apply_bleed)

func apply_bleed():
	if is_bleeding:
		if times_bled <= 2:
			health -= 3
			print("I'm bleeding!")
			times_bled += 1
		else:
			times_bled = 0
			is_bleeding = false
		
func _physics_process(delta: float) -> void:
	if input_allowed:
		var input_vector = Input.get_vector("left", "right", "up", "down")
		velocity = input_vector.normalized() * speed
		move_and_slide()
		
	if velocity.x > 0:
		sprite.scale.x = 1
	if velocity.x < 0:
		sprite.scale.x = -1
		
	# Enemy hitbox detection
	var overlapping_enemies = %PlayerHurtBox.get_overlapping_bodies()
	if overlapping_enemies.size() > 0:
		for enemy in overlapping_enemies:
			print(enemy.name)
			health -= damage_taken * enemy.data.damage * delta
			if enemy.name == "Rat":
				if !is_bleeding:
					is_bleeding = true
		if health <= 0:
			health_depleted.emit()
	
	%Healthbar.value = health
	blood_label.text = "Blood: " + str(blood)

func _input(event):
	if input_allowed:
		# Shooting projectiles
		if event.is_action_pressed("shoot"):
			pivot.look_at(get_global_mouse_position())
			var new_projectile = PROJECTILE.instantiate()
			new_projectile.damage = damage
			new_projectile.speed = 800.0
			new_projectile.global_position = firing_point.global_position
			new_projectile.rotation = (position.angle_to_point(get_global_mouse_position()))
			get_parent().add_child(new_projectile)
