## Abstract class that handles all movement controllers' interactions with other objects.
@abstract
class_name SCMovementController
extends Node

signal collided(collision: KinematicCollision2D)

## The [CharacterBody2D] that will be moved by the controller.
@export var target: CharacterBody2D
## The [enum CharacterBody2D.MotionMode] used for [member target].
## It will dictate if the character is affected by gravity, and will overwrite that of [member target]. 
@export var motion_mode: CharacterBody2D.MotionMode = CharacterBody2D.MOTION_MODE_FLOATING:
	set(value):
		motion_mode = value
		if target:
			target.motion_mode = value

@export var jump_force: float = 500

## The direction that [member target] will try moving towards.
## It will be normalized automatically when set.
var direction: Vector2 = Vector2(0, 0):
	set(value):
		if motion_mode == CharacterBody2D.MOTION_MODE_GROUNDED:
			value = value.project(Vector2.RIGHT)
		direction = value.normalized()

var _knockback_vector: Vector2 = Vector2.ZERO
var _knockback_time_left: float = 0


func _ready() -> void:
	if target:
		target.motion_mode = motion_mode


func _physics_process(delta: float) -> void:
	if not _knockback_vector.is_zero_approx():
		_handle_knockback(delta)
	else:
		if motion_mode == CharacterBody2D.MOTION_MODE_GROUNDED:
			_apply_gravity(delta)
		_update_velocity(delta)
	if target.move_and_slide():
		for i in target.get_slide_collision_count():
			collided.emit(target.get_slide_collision(i))
	


## Abstract function that will be called before every [method CharacterBody2D.move_and_slide].
@abstract func _update_velocity(delta: float) -> void


## Abstract function that will be called before every [method CharacterBody2D.move_and_slide]
## if [member motion_mode] is set to [constant CharacterBody2D.MOTION_MODE_GROUNDED]
## and if [member target] is on the floor.
@abstract func _apply_gravity(delta: float) -> void


## Makes [member target] jump.
## If [param bypass_floor_check] is [code]false[/code],  it will only jump if it's in contact with the floor.
func jump(force: float = jump_force, bypass_floor_check: bool = false) -> void:
	if target.is_on_floor() or bypass_floor_check:
		target.velocity.y -= force


## Applies knockback to [member target], forcing its velocity to [param force]
## for [param duration] seconds. Calling this method again will overwrite previous knockback effects.
func apply_knockback(force: Vector2, duration: float) -> void:
	_knockback_vector = force
	_knockback_time_left = duration


## Immediately clears any ongoing knockback
func clear_knockback() -> void:
	_knockback_vector = Vector2.ZERO
	_knockback_time_left = 0


func _handle_knockback(delta: float) -> void:
	target.velocity = _knockback_vector
	_knockback_time_left -= delta
	if _knockback_time_left <= 0:
		clear_knockback()
