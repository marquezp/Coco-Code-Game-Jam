class_name Projectile
extends Area2D

@onready var timer: Timer = $Timer
@onready var speed: float = 1000.0
@onready var damage: float = 1.0

func _ready() -> void:
	self.body_entered.connect(on_body_entered)
	timer.start()
	timer.timeout.connect(on_timeout)
	
func on_timeout() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
func on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(damage)
		
	
