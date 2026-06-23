class_name AlternateRotation
extends BulletProcessEffect

@export var transition_delay: float = 1
@export var transition_instantaneous: bool = false
@export var rotations: Array[Rotation]

var current_rotation_idx: int = 0
var need_to_rotate: bool = false
var elapsed_time: float = 0


func process(entity: BulletEntity, delta: float) -> void:
	elapsed_time += delta
	if elapsed_time > transition_delay:
		elapsed_time -= transition_delay
		need_to_rotate = true
	if need_to_rotate and transition_instantaneous:
		need_to_rotate = false
		entity.bullet_controller.direction = entity.bullet_controller.direction.rotated(rotations[current_rotation_idx].angle)
		current_rotation_idx = (current_rotation_idx + 1)%rotations.size()
	elif need_to_rotate:
		need_to_rotate = false
		current_rotation_idx = (current_rotation_idx + 1)%rotations.size()
	if not transition_instantaneous:
		entity.bullet_controller.direction = entity.bullet_controller.direction.rotated(rotations[current_rotation_idx].angle * delta)
		
