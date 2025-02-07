class_name BossProjectile extends Projectile


func on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(damage,true)
