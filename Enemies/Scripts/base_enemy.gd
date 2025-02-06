class_name BaseEnemy extends CharacterBody2D

const BLOOD = preload("res://Items/blood.tres")
const PICKUP = preload("res://Items/ItemPickup/item_pickup.tscn")
const PLAYER_SPRITE_SIZE = 50

@export var data: EnemyData

@onready var hitbox: Area2D = $Hitbox
@onready var sprite: Sprite2D = $Sprite2D
@onready var health = data.health
@onready var speed = data.speed
@onready var drops = data.drops.duplicate()


func _physics_process(delta: float) -> void:
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
	
func take_damage(damage) -> void:
	health -= damage
	print(damage)
	if health <= 0.0:
		die()

func load_drops() -> void:
	print("Loading drops")
	var new_drop : DropData = DropData.new()
	new_drop.item = BLOOD
	drops.append(new_drop)
		
func die() -> void:
	# Await animation here...
	WaveManager.enemies_dead += 1
	drop_items()
	queue_free()
	
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
