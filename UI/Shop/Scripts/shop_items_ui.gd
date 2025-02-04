class_name ShopItemsUI extends Control

const SHOP_SLOT = preload("res://UI/Shop/shop_slot.tscn")

@export var data: ShopData

func _ready() -> void:
	update_items_tab()
	ShopManager.update_shop_ui.connect(update_items_tab)

func clear_items_tab() -> void:
	for child in get_children():
		child.queue_free()

func update_items_tab() -> void:
	clear_items_tab()
	for s in data.slots:
		var new_slot = SHOP_SLOT.instantiate()
		add_child(new_slot)
		new_slot.item_data = s
		
