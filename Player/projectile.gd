class_name Projectile extends Area2D

@onready var timer: Timer = $Timer
@onready var speed: float : set = _set_speed
@onready var damage: float : set = _set_damage

func _ready() -> void:
	self.body_entered.connect(on_body_entered)
	timer.start()
	timer.timeout.connect(on_timeout)
	
func on_timeout() -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	
func _set_damage(value: float):
	damage = value

func _set_speed(value: float):
	speed = value

func on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(damage, PlayerManager.is_burn_on())
		
	
