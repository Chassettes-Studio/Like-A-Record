class_name RushBrain
extends EnemyBrain

func process(entity: EnemyEntity, _delta: float) -> void:
	entity.movement_controller.direction = entity.global_position.direction_to(entity.target.global_position)
