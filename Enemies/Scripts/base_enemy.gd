class_name BaseEnemy extends CharacterBody2D

const BLOOD = preload("res://Items/blood.tres")
const PICKUP = preload("res://Items/ItemPickup/item_pickup.tscn")
const PLAYER_SPRITE_SIZE = 50

@export var data: EnemyData

@onready var player : Player = get_tree().get_first_node_in_group("player")
@onready var hitbox: Area2D = $Hitbox

func _ready():
	pass
	
func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	var distance_to_player = global_position.distance_to(player.global_position)
	if is_touching_player():
		velocity = Vector2(0,0)
	else:
		velocity = direction * data.speed
	
	
	move_and_slide()

func is_touching_player() -> bool:
	var overlapping_areas = hitbox.get_overlapping_areas()
	for area in overlapping_areas:
		if area.name == "PlayerHurtBox":
			return true
	return false
	
func take_damage(damage) -> void:
	data.health -= damage
	if data.health <= 0.0:
		die()

func load_drops() -> void:
	var new_drop : DropData = DropData.new()
	new_drop.item = BLOOD
	data.drops.append(new_drop)
		
func die() -> void:
	# Await animation here...
	WaveManager.enemies_dead += 1
	drop_items()
	queue_free()
	
func drop_items() -> void:
	if data.drops.size() == 0:
		return
	for i in data.drops.size():
		if data.drops[i] == null or data.drops[i].item == null:
			continue
		var drop_count : int = data.drops[i].get_drop_count()
		for j in drop_count:
			var drop : ItemPickup = PICKUP.instantiate() as ItemPickup
			drop.item_data = data.drops[i].item
			get_parent().call_deferred("add_child", drop)
			drop.global_position = global_position
			drop.velocity = velocity.rotated(randf_range(-1.5,1.5) * randf_range(0.9, 1.5))
