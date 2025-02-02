extends Area2D

@export var upgrade_label : Label
@export var sprite : Sprite2D
@export var buff : BaseBuff



func _ready() -> void:
	body_entered.connect(on_body_entered)
	sprite.texture = buff.texture
	upgrade_label.text = buff.upgrade_text

func on_body_entered(body: CharacterBody2D):
	if body.name == "Player":
		# This adds the upgrade to our player
		body.buffs.append(buff)
		queue_free()
