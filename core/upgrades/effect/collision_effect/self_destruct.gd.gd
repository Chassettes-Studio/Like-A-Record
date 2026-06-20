class_name SelfDestruct
extends CollisionEffect


func apply(bullet: BulletEntity, _collider: Node2D) -> void:
	bullet.queue_free()
