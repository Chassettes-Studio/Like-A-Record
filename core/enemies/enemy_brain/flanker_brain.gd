class_name FlankerBrain
extends EnemyBrain

@export var attack: EnemyDiscreteAttack
@export var speed: float = 100.0
@export var accel: float = 100.0
@export var flanking_range : float = 300

var speed_rand: float
var accel_rand: float


func ready() -> void:
	speed_rand = randf_range(speed * 0.9, speed * 1.1)
	accel_rand = randf_range(accel * 0.9, accel * 1.1)
	if randi_range(0,1):
		flanking_range *= -1

func get_target_point(entity: EnemyEntity) -> Vector2:
	return entity.target.global_position + entity.global_position.direction_to(entity.target.global_position).rotated(PI/2) * flanking_range


func process(entity: EnemyEntity, _delta: float) -> void:

		entity.movement_controller.direction = entity.global_position.direction_to(get_target_point(entity))
		entity.movement_controller.max_speed = speed_rand
		entity.movement_controller.acceleration = accel_rand

		if entity.global_position.distance_to(entity.target.global_position) < abs(flanking_range) * 2:
			attack.attack(entity)
