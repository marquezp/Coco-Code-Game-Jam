extends CanvasLayer
@onready var texture_rect: TextureRect = $TextureRect
@onready var description: Label = $Description
@onready var amount: Label = $Amount

var update_ui: bool = false
func _ready():
	PlayerManager.player_ready.connect(start_ui)
	texture_rect.mouse_entered.connect(in_focus)
	texture_rect.mouse_exited.connect(out_of_focus)
	description.visible = false

func _process(_delta: float):
	if !update_ui:
		return
	amount.text = str(PlayerManager.get_blood())
	
func start_ui():
	update_ui = true
	
func in_focus() -> void:
	description.visible = true
	
func out_of_focus() -> void:
	description.visible = false
