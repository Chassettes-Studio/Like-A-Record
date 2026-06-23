class_name VaryingSize
extends BulletProcessEffect

@export var min_relative_scale: float = 0.8
@export var max_relative_scale: float = 1
@export var delay: float = 1

var time: float = 0
var is_init: bool = false
var temp_scale: Vector2

func process(entity: BulletEntity, delta: float) -> void:
	if not is_init:
		temp_scale = entity.sprite.scale
		is_init = true
	time += delta/delay
	entity.sprite.scale = (temp_scale * (max_relative_scale-min_relative_scale) * abs(sin(time))) + (min_relative_scale*temp_scale)
	#var shape := CircleShape2D.new()
	#shape.radius = (entity.bullet_data.size * (max_relative_scale-min_relative_scale) * abs(sin(time))) + (min_relative_scale*entity.bullet_data.size)
	#entity.area_collision.shape = shape.duplicate()
	#entity.body_collision.shape = shape.duplicate()
