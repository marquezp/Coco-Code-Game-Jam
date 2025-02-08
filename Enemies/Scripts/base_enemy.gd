class_name BaseEnemy extends CharacterBody2D

const BLOOD = preload("res://Items/blood.tres")
const PICKUP = preload("res://Items/ItemPickup/item_pickup.tscn")
const PLAYER_SPRITE_SIZE = 50

@export var data: EnemyData
@export var knockback_power: float = 1000

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area2D = $Hitbox
@onready var sprite: Sprite2D = $Sprite2D
@onready var burn_timer: Timer = $BurnTimer
@onready var health = data.health
@onready var speed = data.speed
@onready var drops = data.drops.duplicate()
@onready var damage_numbers_origin: Node2D = $DamageNumbersOrigin
@onready var hit_flash_animation_player: AnimationPlayer = $HitFlashAnimationPlayer


var is_dead: bool = false
var is_burning: bool = false
var times_burnt: int = 0

func _ready():
	burn_timer.timeout.connect(apply_burn)
	add_to_group("enemy")
	
func apply_burn():
	if !is_dead and is_burning:
		if times_burnt <= 2:
			take_damage(PlayerManager.get_burn_damage(),false,true)
			times_burnt += 1
		else:
			times_burnt = 0
			is_burning = false
	
func _physics_process(_delta: float) -> void:
	#animation_player.play("walk")
	if is_dead:
		return
	var direction = global_position.direction_to(PlayerManager.player.global_position)
	if is_touching_player():
		velocity = Vector2(0,0)
	else:
		velocity = direction * speed
	
	if velocity.x > 0:
			sprite.flip_h = false
	if velocity.x < 0:
			sprite.flip_h = true
		
	move_and_slide()

func is_touching_player() -> bool:
	var overlapping_areas = hitbox.get_overlapping_areas()
	for area in overlapping_areas:
		if area.name == "PlayerHurtBox":
			return true
	return false

func knock_back():
	var knockbackDirection = -velocity.normalized() * knockback_power
	velocity = knockbackDirection
	move_and_slide()
	
func take_damage(damage, burn: bool = false, is_burn_damage: bool = false) -> void:
	health -= damage
	DamageNumbers.display_number(damage,damage_numbers_origin.global_position,is_burn_damage)
	if health <= 0.0:
		die()
		return
	#knock_back()
	hit_flash_animation_player.play("hit_flash")
	if burn and !is_burning:
		is_burning = true
		burn_timer.start()
			
func die() -> void:
	if is_dead:
		return
	# Await animation here...
	drop_items()
	is_dead = true
	animation_player.play("die")
	await animation_player.animation_finished
	queue_free()
	print("dead: ", self.name)
	WaveManager.update_enemy_deaths()
	
func drop_items() -> void:
	if drops.size() == 0:
		return
	for i in drops.size():
		if drops[i] == null or drops[i].item == null:
			continue
		var drop_count : int = drops[i].get_drop_count()
		for j in drop_count:
			var drop : ItemPickup = PICKUP.instantiate() as ItemPickup
			drop.item_data = drops[i].item
			get_parent().call_deferred("add_child", drop)
			drop.global_position = global_position
			drop.velocity = velocity.rotated(randf_range(-1.5,1.5) * randf_range(0.9, 1.5))
