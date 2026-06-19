## Movement controller based on physics.
##
## The character can recieve impulses via directly setting its velocity.
class_name SCPhysicsController
extends SCMovementController

## Max movement speed of the character in pixel/second.
## External forces CAN make the speed exceed this value.
@export var max_speed: float = 100
## Acceleration of the character in pixel/second².
@export var acceleration: float = 100


func _apply_gravity(delta: float) -> void:
	target.velocity += target.get_gravity() * delta


func _update_velocity(delta: float) -> void:
	match motion_mode:
		CharacterBody2D.MOTION_MODE_FLOATING:
			target.velocity = target.velocity.move_toward(direction * max_speed, delta * acceleration)
		CharacterBody2D.MOTION_MODE_GROUNDED:
			target.velocity.x = move_toward(target.velocity.x, direction.x * max_speed, delta * acceleration)
