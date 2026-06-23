class_name StaticAfterDistance
extends BulletProcessEffect

@export var distance: float = 500
@export var idle_duration: float = 2
@export var loop: bool = true
@export var process_effect_on_idle: BulletProcessEffect

var elapsed_time: float = 0
var is_idle: bool = false
var init: bool = false
var initial_position: Vector2

func process(entity: BulletEntity, delta: float) -> void:
	if is_idle:
		elapsed_time += delta
	if not init:
		init = true
		initial_position = entity.global_position
	if not is_idle and initial_position.distance_to(entity.global_position) > distance:
		initial_position = entity.global_position
		entity.bullet_controller.set_physics_process(false)
		is_idle = true
	if loop and is_idle and elapsed_time > idle_duration:
		elapsed_time -= idle_duration
		entity.bullet_controller.set_physics_process(true)
		is_idle = false
	if is_idle and process_effect_on_idle:
		process_effect_on_idle.process(entity, delta)
