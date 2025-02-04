extends Node

# Game Items
const DAMAGE = preload("res://Items/damage.tres")
const SPEED = preload("res://Items/speed.tres")
const BLOOD = preload("res://Items/blood.tres")

@onready var shop: CanvasLayer = get_node("/root/Game/Shop")

signal update_shop_ui

const POSSIBLE_ITEMS : Array[ItemData] = [DAMAGE,SPEED,BLOOD]
var SHOP_ITEMS_RESOURCE = preload("res://UI/Shop/shop_items.tres")

func open_shop():
	PlayerManager.set_input_allowed(false)
	generate_shop_items()
	update_shop_ui.emit()
	shop.visible = true
	
func close_shop():
	shop.visible = false
	PlayerManager.set_input_allowed(true)
	WaveManager.start_next_wave()

# Right now this is taking out items that have already been added to the shop
# from the possible list of pickable items
func generate_shop_items():
	var items_available =  POSSIBLE_ITEMS.duplicate()
	for i in SHOP_ITEMS_RESOURCE.slots.size():
		SHOP_ITEMS_RESOURCE.slots[i] = null
		var random_item: ItemData = items_available.pick_random()
		SHOP_ITEMS_RESOURCE.add_item(random_item)
		items_available.erase(random_item)
