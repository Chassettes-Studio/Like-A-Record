class_name VaryingSpeed
extends BulletProcessEffect

@export var added_speed_per_second: float = 100

func process(entity: BulletEntity, delta: float) -> void:
	entity.bullet_controller.max_speed += added_speed_per_second * delta
