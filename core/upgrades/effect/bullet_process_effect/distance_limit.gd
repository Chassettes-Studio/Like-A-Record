class_name DistanceLimit
extends BulletProcessEffect

@export var distance_limit: float = 1000

var init: bool = false
var initial_position: Vector2

func process(entity: BulletEntity, _delta: float) -> void:
	if not init:
		init = true
		initial_position = entity.global_position
	if initial_position.distance_to(entity.global_position) > distance_limit:
		entity.free()
