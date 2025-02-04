extends CanvasLayer
@onready var item_description: Label = $ItemDescription
@onready var next_wave_button: Button = $MainPanel/NextWaveButton
@onready var cleanse_button: Button = $MainPanel/CleanseButton

func _ready():
	visible = false
	next_wave_button.pressed.connect(_on_next_wave_pressed)
	cleanse_button.pressed.connect(_on_cleanse_button_pressed)
	
func update_item_description(new_text : String) -> void:
	item_description.text = new_text
	
func _on_next_wave_pressed():
	ShopManager.close_shop()
	
func _on_cleanse_button_pressed():
	PlayerManager.remove_buffs()
