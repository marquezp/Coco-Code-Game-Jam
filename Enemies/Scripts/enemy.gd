extends CharacterBody2D

const BLOOD = preload("res://Items/blood.tres")

const DAMAGE = preload("res://Items/damage.tres")
const SPEED = preload("res://Items/speed.tres")

const PICKUP = preload("res://Items/ItemPickup/item_pickup.tscn")
@export var health : float = 3.0
@export var speed = 200.0
@onready var player: CharacterBody2D = $"../Player"

@export_category("Item Drops")
@export var drops : Array[DropData]

func _ready():
	load_drops()
	
func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * speed
	move_and_slide()

func take_damage(damage):
	health -= damage
	print("OW")
	print(damage)
	if health <= 0.0:
		die()

func load_drops():
	var new_drop : DropData = DropData.new()
	new_drop.item = BLOOD
	drops.append(new_drop)
		
func die():
	# Await animation here...
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
