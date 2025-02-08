extends CanvasLayer
@onready var item_name: Label = $ItemName
@onready var item_description: Label = $ItemDescription
@onready var next_wave_button: Button = $MainPanel/NextWaveButton
@onready var cleanse_button: Button = $MainPanel/CleanseButton

const DOWNARROW = preload("res://Assets/Art/downarrow.png")
const CROSSEDSWORDS = preload("res://Assets/Art/crossedswords.png")

func _ready():
	visible = false
	next_wave_button.pressed.connect(_on_next_wave_pressed)
	cleanse_button.pressed.connect(_on_cleanse_button_pressed)
	cleanse_button.mouse_entered.connect(_on_cleanse_button_hover)
	cleanse_button.mouse_exited.connect(_on_cleanse_button_exited)
	next_wave_button.mouse_entered.connect(_on_next_wave_button_hover)
	next_wave_button.mouse_exited.connect(_on_next_wave_button_exited)
	
func update_item_description(new_text : String) -> void:
	item_description.text = new_text

func update_item_name(new_text: String) -> void:
	item_name.text = new_text
	
func _on_next_wave_pressed() -> void:
	ShopManager.close_shop()
	
func _on_cleanse_button_pressed() -> void:
	PlayerManager.remove_buffs()

func _on_cleanse_button_hover() -> void:
	Input.set_custom_mouse_cursor(
		DOWNARROW,
		Input.CURSOR_ARROW,
		Vector2(16,16)
	)
	update_item_name("Removes all active poison effects")

func _on_cleanse_button_exited() -> void:
	Input.set_custom_mouse_cursor(
		null,
		Input.CURSOR_ARROW,
		Vector2(0,0)
	)
	update_item_name("")
	
func _on_next_wave_button_hover() -> void:
	Input.set_custom_mouse_cursor(
		CROSSEDSWORDS,
		Input.CURSOR_ARROW,
		Vector2(16,16)
	)
	update_item_name("Fight on!")

func _on_next_wave_button_exited() -> void:
	Input.set_custom_mouse_cursor(
		null,
		Input.CURSOR_ARROW,
		Vector2(0,0)
	)
	update_item_name("")
