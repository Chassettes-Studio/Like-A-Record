class_name RushBrain
extends EnemyBrain

@export var speed: float = 100.0
@export var accel: float = 100.0

var speed_rand: float
var accel_rand: float

func ready() -> void:
	speed_rand = randf_range(speed * 0.9, speed * 1.1)
	accel_rand = randf_range(accel * 0.9, accel * 1.1)

func process(entity: EnemyEntity, _delta: float) -> void:
	entity.movement_controller.direction = entity.global_position.direction_to(entity.target.global_position)
	entity.movement_controller.max_speed = speed_rand
	entity.movement_controller.acceleration = accel_rand
	entity.rotation = entity.velocity.angle() + PI/2
