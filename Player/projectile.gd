class_name Projectile
extends Area2D

@onready var timer: Timer = $Timer
@onready var speed: float = 1000.0
@onready var damage: float : set = _set_damage

func _ready() -> void:
	self.area_entered.connect(on_area_entered)
	timer.start()
	timer.timeout.connect(on_timeout)
	
func on_timeout() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
func _set_damage(value: float):
	damage = value
	
func on_area_entered(area):
	if area.has_method("take_damage"):
		area.take_damage(damage)
		queue_free()
		
	
