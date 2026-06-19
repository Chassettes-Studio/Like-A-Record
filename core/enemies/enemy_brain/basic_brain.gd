class_name BasicBrain
extends EnemyBrain

enum State {
	CHASE,
	SHOOT,
}

@export var chase_stop_distance: float
@export var chase_start_distance: float

var state: State = State.CHASE


func change_state() -> void:
	match state:
		State.CHASE:
			if entity.global_position.distance_to(target.global_position) < chase_stop_distance:
				state = State.SHOOT
		State.SHOOT:
			if entity.global_position.distance_to(target.global_position) > chase_start_distance:
				state = State.CHASE


func process(delta: float) -> void:

	change_state()

	match state:
		State.CHASE:
			movement_controller.direction = entity.global_position.direction_to(target.global_position)
		State.SHOOT:
			movement_controller.direction = Vector2.ZERO
			attack.attack(delta)
