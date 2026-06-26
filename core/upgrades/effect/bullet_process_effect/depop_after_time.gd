class_name DepopAfterTime
extends BulletProcessEffect

@export var duration : float

func process(entity: BulletEntity, delta: float) -> void:
	duration -= delta
	if duration <= 0:
		entity.queue_free()
