class_name Player extends CharacterBody2D

const PROJECTILE = preload("res://Player/projectile.tscn")

# Base (starting) Player Attributes
@export var base_damage: float = 1.0
@export var base_damage_taken: float = 10.0
@export var base_speed: float = 250.0
@export var base_health_regen: float = 0.2
@export var base_max_health: float = 100.0
@export var base_burn: float = 0.0
@export var base_attack_speed: float = 0.6

# other exports
@export var self_burn_chance: float = 0.15

# Current player attributes
@onready var damage: float = base_damage
@onready var damage_taken: float = base_damage_taken
@onready var speed: float = base_speed
@onready var health_regen: float = base_health_regen
@onready var max_health: float = base_max_health
@onready var health: float = base_max_health
@onready var burn: float = base_burn
@onready var attack_speed : float = base_attack_speed

# Blood (currency for shop)
@export var blood : int = 0

# Timers, etc
@onready var attack_timer: Timer = $AttackTimer
@onready var bleed_timer: Timer = $BleedTimer
@onready var slow_timer: Timer = $SlowTimer
@onready var firing_point: Marker2D = $PlayerSprite/Pivot/FiringPoint
@onready var pivot: Marker2D = $PlayerSprite/Pivot
@onready var sprite: Sprite2D = $PlayerSprite
@onready var damage_numbers_origin: Node2D = $DamageNumbersOrigin

# Sound effects
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
const PLAYERHIT_1 = preload("res://Assets/Audio/playerhit1.wav")
const PLAYERHIT_2 = preload("res://Assets/Audio/playerhit2.wav")
const PLAYERHIT_3 = preload("res://Assets/Audio/playerhit3.wav")
const PLAYERHIT_4 = preload("res://Assets/Audio/playerhit4.wav")
const PLAYERHIT_5 = preload("res://Assets/Audio/playerhit5.wav")
const sounds: Array[AudioStreamWAV] = [PLAYERHIT_1,PLAYERHIT_2, PLAYERHIT_3, PLAYERHIT_4, PLAYERHIT_5] 

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Bools and other checkers
var input_allowed: bool = true
var is_bleeding: bool = false
var burn_on: bool = false
var times_bled: int = 0
var pre_slow_speed: float


func _ready():
	bleed_timer.timeout.connect(apply_bleed)
	slow_timer.timeout.connect(remove_slow)
	attack_timer.wait_time = attack_speed

# checks every 1.5 seconds to see if player is bleeding, then applies it
func apply_bleed():
	if is_bleeding:
		if times_bled <= 2:
			make_noise()
			DamageNumbers.display_number(3,damage_numbers_origin.global_position)
			health -= 3
			times_bled += 1
		else:
			times_bled = 0
			is_bleeding = false

# returns speed back to normal after slow timer ends
func remove_slow():
	speed = pre_slow_speed

func max_health_changed():
	health = min(health, max_health)
	%Healthbar.max_value = max_health
	
func make_noise():
	if !audio_stream_player.playing:
		audio_stream_player.stream = sounds.pick_random()
		audio_stream_player.play()
			
func _physics_process(delta: float) -> void:
	sprite.modulate = "#FFF"
	if input_allowed:
		var input_vector = Input.get_vector("left", "right", "up", "down")
		velocity = input_vector.normalized() * speed
		move_and_slide()
	
	# Flipping sprites
	if velocity.x > 0:
		sprite.scale.x = 1
	if velocity.x < 0:
		sprite.scale.x = -1
	
	if abs(velocity) > Vector2(0,0):
		if !animation_player.is_playing():
			animation_player.play("walk")
		
	# Enemy hitbox detection
	var overlapping_enemies = %PlayerHurtBox.get_overlapping_bodies()
	if overlapping_enemies.size() > 0:
		for enemy in overlapping_enemies:
			print(enemy.name)
			make_noise()
			sprite.modulate = "#FF3030"
			health -= damage_taken * enemy.data.damage * delta
			if enemy.name == "Rat":
				if !is_bleeding:
					is_bleeding = true
		
	# Health Regen
	if input_allowed:
		if health_regen < 0:
			health += health_regen * delta
		elif health < 100:
			health += health_regen * delta
		
	# Update health and currency
	%Healthbar.value = health
	
	if health <= 0:
		PlayerManager.health_depleted.emit()
		input_allowed = false
	
	# Shooting projectiles
	if input_allowed and Input.is_action_pressed("shoot"):
		if attack_timer.is_stopped():
			shoot()
			
# this is just for incoming projectiles
func take_damage(value: float, effect: bool = false):
	make_noise()
	health -= value * damage_taken
	if effect:
		slow_timer.start()
		pre_slow_speed = speed
		speed *= 0.6

func shoot():
	pivot.look_at(get_global_mouse_position())
	var new_projectile = PROJECTILE.instantiate()
	new_projectile.damage = damage
	new_projectile.speed = 800.0
	new_projectile.global_position = firing_point.global_position
	new_projectile.rotation = (position.angle_to_point(get_global_mouse_position()))
	get_parent().add_child(new_projectile)
	attack_timer.wait_time = attack_speed
	attack_timer.start()
	animation_player.play("hawk_twah")

	# Player burns themselves
	if burn_on:
		if randf() < self_burn_chance: # chance to burn yourself
			print("burnt myself for ", burn)
			health -= burn
			make_noise()
			DamageNumbers.display_number(burn,damage_numbers_origin.global_position,true)

	
	
