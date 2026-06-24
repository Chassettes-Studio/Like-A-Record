class_name AbilityKnockback
extends AbilityEffect

@export var shape : Shape2D
@export var force : float = 100
@export var duration : float = 0.2

func use(player: Player) -> void:
	
	var query := PhysicsShapeQueryParameters2D.new()
	query.transform = player.global_transform
	query.shape = shape
	var collisions := player.get_world_2d().direct_space_state.intersect_shape(query)
	
	for entry in collisions:
		var enemy := entry.collider as EnemyEntity
		if enemy:
			enemy.movement_controller.apply_knockback(player.global_position.direction_to(enemy.global_position) * force, duration)

	
