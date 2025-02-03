extends Node

# Game Items
const DAMAGE = preload("res://Items/damage.tres")
const SPEED = preload("res://Items/speed.tres")

const POSSIBLE_ITEMS = [DAMAGE,SPEED]
var SHOP_ITEMS = preload("res://UI/Shop/shop_items.tres")

func _ready():
	generate_shop_items()
	
func generate_shop_items():
	for i in SHOP_ITEMS.slots.size():
		var random_item = POSSIBLE_ITEMS.pick_random()
		SHOP_ITEMS.slots[i] = random_item
