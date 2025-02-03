extends CanvasLayer
@onready var item_description: Label = $ItemDescription

func update_item_description(new_text : String) -> void:
	item_description.text = new_text
