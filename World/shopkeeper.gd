extends CharacterBody2D

@onready var interact_radius: Area2D = $InteractRadius

func _ready() -> void:
	interact_radius.visible = true
	ShopManager.despawn_shop.connect(despawn)

func despawn():
	queue_free()
	
func _process(delta: float) -> void:
	var overlapping_bodies: Array[Node2D] = interact_radius.get_overlapping_bodies()
	if interact_radius.visible:
		if Input.is_action_just_pressed("interact"):
			for body in overlapping_bodies:
				print(body)
				if body.name == "Player":
					ShopManager.open_shop()
					interact_radius.visible = false

		
	
