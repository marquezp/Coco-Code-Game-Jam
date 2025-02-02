@tool
extends Area2D

@export var upgrade_label : Label
@export var sprite : Sprite2D
@export var projectile_upgrade : BaseProjectileBuff:
	set(val):
		projectile_upgrade = val
		needs_update = true

# Used when editing to denote that the sprite has changed and needs updating
@export var needs_update := false

func _ready() -> void:
	body_entered.connect(on_body_entered)
	sprite.texture = projectile_upgrade.texture
	upgrade_label.text = projectile_upgrade.upgrade_text


func _process(delta: float) -> void:
	# This is run only when we're editing the scene
	# It updates the texture of the sprite when we replace the upgrade
	if Engine.is_editor_hint():
		if needs_update:
			sprite.texture = projectile_upgrade.texture
			upgrade_label.text = projectile_upgrade.upgrade_text
			needs_update = false

func on_body_entered(body: CharacterBody2D):
	if body.name == "Player":
		# This adds the upgrade to our player which the player uses when firing
		body.projectile_buffs.append(projectile_upgrade)
		
		queue_free()
