class_name BulletFaster
extends BulletEffect

@export var speed := 100.0

func apply(entity: BulletEntity) -> void:
	entity.bullet_controller.max_speed += speed
