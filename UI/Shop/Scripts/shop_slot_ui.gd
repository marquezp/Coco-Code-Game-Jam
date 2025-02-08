class_name ShopSlotUI extends Button

@onready var texture_rect: TextureRect = $TextureRect
@onready var shop: CanvasLayer = $"../../../"
const UPARROW = preload("res://Assets/Art/uparrow.png")

var item_data : ItemData : set = set_item_data

func _ready() -> void:
	texture_rect.texture = null
	mouse_entered.connect(item_focused)
	mouse_exited.connect(item_unfocused)
	pressed.connect(item_pressed)

func set_item_data(value:ItemData) -> void:
	item_data = value
	if item_data == null:
		return
	texture_rect.texture = item_data.texture
	
func item_pressed() -> void:
	if item_data == null:
		return
	ShopManager.buy_item(item_data)
	
func item_focused() -> void:
	Input.set_custom_mouse_cursor(
		UPARROW,
		Input.CURSOR_ARROW,
		Vector2(16,16)
	)
	if item_data != null:
		shop.update_item_description(item_data.description)
		shop.update_item_name(item_data.name + " ("+str(item_data.shop_cost)+" blood)")

func item_unfocused() -> void:
	Input.set_custom_mouse_cursor(
		null,
		Input.CURSOR_ARROW,
		Vector2(0,0)
	)
	shop.update_item_description("")
	shop.update_item_name("")
