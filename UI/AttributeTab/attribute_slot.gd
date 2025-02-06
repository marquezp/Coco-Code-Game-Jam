extends Panel
@onready var icon: TextureRect = $Icon
@onready var label: Label = $Label
@onready var update_ui: bool = false

@export var texture: Texture2D
@export var icon_name: String

func _ready() -> void:
	icon.texture = texture
	PlayerManager.player_ready.connect(start_ui)

func start_ui():
	update_ui = true
	
func _process(_delta: float) -> void:
	if update_ui:
		if icon_name == "Damage":
			label.text = str(PlayerManager.player.damage)
		if icon_name == "Health":
			label.text = str(int(PlayerManager.player.health))
		if icon_name == "Speed":
			label.text = str(PlayerManager.player.speed)
