class_name VaryingSize
extends BulletProcessEffect

var time: float = 0
var is_init: bool = false
var temp_scale: Vector2

func process(entity: BulletEntity, delta: float) -> void:
	if not is_init:
		temp_scale = entity.sprite.scale
		is_init = true
	time += delta
	entity.sprite.scale = temp_scale * abs(sin(time))
