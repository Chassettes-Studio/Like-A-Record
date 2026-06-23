class_name RushBrain
extends EnemyBrain

@export var speed: float = 100.0
@export var accel: float = 100.0

func process(entity: EnemyEntity, _delta: float) -> void:
	entity.movement_controller.direction = entity.global_position.direction_to(entity.target.global_position)
	entity.movement_controller.max_speed = speed
	entity.movement_controller.acceleration = accel
	entity.rotation = entity.velocity.angle() + PI/2
