class_name AddPierce
extends BulletEffect

@export var pierces : int = 1

func apply(entity: BulletEntity) -> void:
	entity.pierces += pierces
