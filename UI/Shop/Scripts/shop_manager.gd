extends Node

# Game Items
const DAMAGE = preload("res://Items/damage.tres")
const SPEED = preload("res://Items/speed.tres")
const ARMOR = preload("res://Items/armor.tres")
const FIRE = preload("res://Items/fire.tres")
const ATTSPEED = preload("res://Items/attspeed.tres")
const REGEN = preload("res://Items/regen.tres")

var shop: CanvasLayer 

const SHOPKEEPER = preload("res://World/shopkeeper.tscn")
signal update_shop_ui
signal despawn_shop

const POSSIBLE_ITEMS : Array[ItemData] = [DAMAGE,SPEED,ARMOR,FIRE,ATTSPEED,REGEN]
var SHOP_ITEMS_RESOURCE = preload("res://UI/Shop/shop_items.tres")

func get_shop(shop_instance: CanvasLayer):
	shop = shop_instance
	
func spawn_shop():
	# Call this after wave end
	var shopkeeper = SHOPKEEPER.instantiate()
	shopkeeper.global_position = PlayerManager.player.global_position + Vector2(150,-20)
	get_tree().current_scene.call_deferred("add_child",shopkeeper)
	
func open_shop():
	PlayerManager.set_input_allowed(false)
	generate_shop_items()
	update_shop_ui.emit()
	shop.visible = true
	Input.set_custom_mouse_cursor(
		null,
		Input.CURSOR_ARROW,
		Vector2(0,0)
	)
	
func close_shop():
	shop.visible = false
	PlayerManager.set_input_allowed(true)
	WaveManager.start_next_wave()
	despawn_shop.emit()

func buy_item(item: ItemData):
	# Buying Item
	if PlayerManager.get_blood()  >= item.shop_cost: # can we afford it?
		if PlayerManager.add_buffs(item): # do we have space in the buffs tab?
			print("I bought the item: ", item.name)
			PlayerManager.update_blood(-item.shop_cost)
			# Find the item in the shop Resource and make it null 
			for i in range(SHOP_ITEMS_RESOURCE.slots.size()):
				if item == SHOP_ITEMS_RESOURCE.slots[i]:
					SHOP_ITEMS_RESOURCE.slots[i] = null
			update_shop_ui.emit()
		else: # no space in buffs tab
			#TODO add some sort of error message/red outline
			print("no space in buffs tab")
	else: # can't afford the item
		#TODO add some sort of error message/red outline
		print("can't afford item")
	
# Right now this is taking out items that have already been added to the shop
# from the possible list of pickable items
func generate_shop_items():
	var items_available =  POSSIBLE_ITEMS.duplicate()
	for i in SHOP_ITEMS_RESOURCE.slots.size():
		SHOP_ITEMS_RESOURCE.slots[i] = null
		var random_item: ItemData = items_available.pick_random()
		SHOP_ITEMS_RESOURCE.add_item(random_item)
		items_available.erase(random_item)
