class_name AddBounce
extends BulletEffect

@export var bounces : int

func apply(entity: BulletEntity) -> void:
	entity.bounces += bounces
