class_name TimeLimit
extends BulletProcessEffect

@export var time_limit: float = 5

var elapsed_time: float = 0

func process(entity: BulletEntity, delta: float) -> void:
	elapsed_time += delta
	if elapsed_time > time_limit:
		entity.free()
