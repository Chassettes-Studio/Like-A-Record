class_name BulletController
extends SCMovementController

@export var max_speed: float = 200

func _physics_process(delta: float) -> void:
	if not _knockback_vector.is_zero_approx():
		_handle_knockback(delta)
	else:
		if motion_mode == CharacterBody2D.MOTION_MODE_GROUNDED:
			_apply_gravity(delta)
		_update_velocity(delta)
	var collision := target.move_and_collide(target.velocity * delta)
	if collision:
		collided.emit(collision)

func _update_velocity(_delta: float) -> void:
	target.velocity = direction * max_speed


func _apply_gravity(_delta: float) -> void:
	return
