class_name BanditProjectile extends Projectile

func _ready():
	self.body_entered.connect(on_body_entered)
	timer.start()
	timer.timeout.connect(on_timeout)
	set_collision_mask_value(3,true)
	set_collision_mask_value(1,false)

func on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(damage)
