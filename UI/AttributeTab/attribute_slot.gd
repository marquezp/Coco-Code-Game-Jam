extends Panel
@onready var icon: TextureRect = $Icon
@onready var label: Label = $Label
@onready var description: Label = $Description
@onready var update_ui: bool = false

@export var texture: Texture2D
@export var icon_name: String

func _ready() -> void:
	icon.texture = texture
	PlayerManager.player_ready.connect(start_ui)
	mouse_entered.connect(item_focused)
	mouse_exited.connect(item_unfocused)

func start_ui():
	update_ui = true
	
func item_focused():
	if icon_name == "Damage":
		description.text = "Projectile Damage"
	if icon_name == "Health":
		description.text = "Health"
	if icon_name == "Speed":
		description.text = "Speed"
	if icon_name == "HealthRegen":
		description.text = "Health Regen"
	if icon_name == "AttackSpeed":
		description.text = "Projectile Delay"
	if icon_name == "DamageTaken":
		description.text = "Incoming damage multiplier"
	
	
func item_unfocused():
	description.text = ""
	
func _process(_delta: float) -> void:
	if update_ui:
		if icon_name == "Damage":
			label.text = str(floor(PlayerManager.player.damage * 10) /10.0)
		if icon_name == "Health":
			label.text = str(int(PlayerManager.player.health))
		if icon_name == "Speed":
			label.text = str(PlayerManager.player.speed)
		if icon_name == "HealthRegen":
			label.text = str(PlayerManager.player.health_regen)
		if icon_name == "AttackSpeed":
			label.text = str(PlayerManager.player.attack_speed) + "s"
		if icon_name == "DamageTaken":
			label.text = str(PlayerManager.player.damage_taken / 10)
