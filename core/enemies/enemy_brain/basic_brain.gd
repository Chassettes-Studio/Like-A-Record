class_name BasicBrain
extends EnemyBrain

enum BrainState {
	CHASE,
	SHOOT,
}

@export var chase_stop_distance: float
@export var chase_start_distance: float
@export var attack: EnemyDiscreteAttack

var state: BrainState = BrainState.CHASE


func change_state(entity : EnemyEntity) -> void:
	match state:
		BrainState.CHASE:
			if entity.global_position.distance_to(entity.target.global_position) < chase_stop_distance:
				state = BrainState.SHOOT
		BrainState.SHOOT:
			if entity.global_position.distance_to(entity.target.global_position) > chase_start_distance:
				state = BrainState.CHASE


func process(entity: EnemyEntity, delta: float) -> void:

	change_state(entity)

	match state:
		BrainState.CHASE:
			entity.movement_controller.direction = entity.global_position.direction_to(entity.target.global_position)
		BrainState.SHOOT:
			entity.movement_controller.direction = Vector2.ZERO
			attack.attack(entity)
