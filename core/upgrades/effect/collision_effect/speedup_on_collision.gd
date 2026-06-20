class_name SpeedupOnCollision
extends CollisionEffect

@export var amount : float

func apply(bullet: BulletEntity, _collider: Node2D) -> void:
	bullet.bullet_controller.max_speed += amount
