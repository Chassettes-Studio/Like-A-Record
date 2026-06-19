class_name BulletController
extends SCMovementController

@export var max_speed: float = 200


func _update_velocity(_delta: float) -> void:
	target.velocity = direction * max_speed


func _apply_gravity(_delta: float) -> void:
	return
