class_name ShopSlotUI extends Button

@onready var texture_rect: TextureRect = $TextureRect
@onready var shop: CanvasLayer = $"../../../.."

var item_data : ItemData : set = set_item_data

func _ready() -> void:
	texture_rect.texture = null
	mouse_entered.connect(item_focused)
	mouse_exited.connect(item_unfocused)

func set_item_data(value:ItemData) -> void:
	item_data = value
	if item_data == null:
		return
	texture_rect.texture = item_data.texture

func item_focused() -> void:
	if item_data != null:
		shop.update_item_description(item_data.description)

func item_unfocused() -> void:
	shop.update_item_description("")
