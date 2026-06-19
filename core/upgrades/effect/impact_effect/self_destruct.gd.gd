class_name SelfDestruct
extends ImpactEffect

func apply(_target: Node2D) -> void:
	bullet.queue_free()
