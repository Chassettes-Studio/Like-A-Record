class_name BasicBrain
extends EnemyBrain

enum BrainState {
	CHASE,
	SHOOT,
}

@export var chase_stop_distance: float
@export var chase_start_distance: float
@export var attack: EnemyDiscreteAttack
@export var speed: float = 100.0
@export var accel: float = 100.0

var state: BrainState = BrainState.CHASE

var speed_rand: float
var accel_rand: float


func ready() -> void:
	speed_rand = randf_range(speed * 0.9, speed * 1.1)
	accel_rand = randf_range(accel * 0.9, accel * 1.1)


func change_state(entity: EnemyEntity) -> void:
	match state:
		BrainState.CHASE:
			if entity.global_position.distance_to(entity.target.global_position) < chase_stop_distance:
				state = BrainState.SHOOT
		BrainState.SHOOT:
			if entity.global_position.distance_to(entity.target.global_position) > chase_start_distance:
				state = BrainState.CHASE


func process(entity: EnemyEntity, _delta: float) -> void:

	change_state(entity)

	match state:
		BrainState.CHASE:
			entity.movement_controller.direction = entity.global_position.direction_to(entity.target.global_position)
			entity.movement_controller.max_speed = speed_rand
			entity.movement_controller.acceleration = accel_rand

		BrainState.SHOOT:
			entity.movement_controller.direction = Vector2.ZERO
			attack.attack(entity)
