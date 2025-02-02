class_name BuffSlotUI extends Panel

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label
@onready var buffs_tab: CanvasLayer = $"../../.."

var slot_data : SlotData : set = set_slot_data

func _ready() -> void:
	texture_rect.texture = null
	label.text = ""
	mouse_entered.connect(item_focused)
	mouse_exited.connect(item_unfocused)

func set_slot_data(value:SlotData) -> void:
	slot_data = value
	if slot_data == null:
		return
	texture_rect.texture = slot_data.item_data.texture
	label.text = str(slot_data.quantity)

func item_focused() -> void:
	if slot_data != null:
		if slot_data.item_data != null:
			buffs_tab.update_item_description(slot_data.item_data.description)

func item_unfocused() -> void:
	buffs_tab.update_item_description("")
