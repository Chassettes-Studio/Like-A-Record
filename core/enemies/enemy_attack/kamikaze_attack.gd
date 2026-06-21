class_name KamikazeAttack
extends EnemyDiscreteAttack

var target: Player

@export var explosion_area_radius: float = 20


func attack(enemy: EnemyEntity) -> void:
	var circle_shape: CircleShape2D = CircleShape2D.new()
	circle_shape.radius = explosion_area_radius
	var shape_query: PhysicsShapeQueryParameters2D = PhysicsShapeQueryParameters2D.new()
	shape_query.shape = circle_shape
	shape_query.collide_with_areas = true
	shape_query.collision_mask = 1
	var results := enemy.get_world_2d().direct_space_state.intersect_shape(shape_query)
	for result in results:
		var hb := result.collider as Hitbox
		if hb:
			hb.damage(1)
	enemy.die()
