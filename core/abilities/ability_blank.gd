class_name AbilityBlank
extends PlayerEffect

@export var shape : Shape2D

func apply(player: Player) -> void:
	
	var query := PhysicsShapeQueryParameters2D.new()
	query.transform = player.global_transform
	query.shape = shape
	var collisions := player.get_world_2d().direct_space_state.intersect_shape(query)
	
	for entry in collisions:
		var bullet := entry.collider as BulletEntity
		if bullet && bullet.area_2d.get_collision_mask_value(1):
			bullet.queue_free()

	
	
