class_name Spawner
extends Node2D

const SPAWN_MAX_TRY_COUNT: int = 100
const enemy_scene: PackedScene = preload("res://core/enemies/entity/enemy_entity.tscn")

@export var target: Player
@export var top_left_corner: Vector2
@export var bottom_down_corner: Vector2
@export var player_view_radius: float

var spawn_try_count: int = 0


func spawn_enemy(resource: Enemy) -> EnemyEntity:

	if not is_instance_valid(target): return

	var spawn_position: Vector2 = Vector2(0, 0)
	while spawn_try_count < SPAWN_MAX_TRY_COUNT:
		spawn_position.x = randf_range(top_left_corner.x, bottom_down_corner.x)
		spawn_position.y = randf_range(top_left_corner.y, bottom_down_corner.y)
		if (
				(
					spawn_position.x < target.position.x - player_view_radius
					or spawn_position.x > target.position.x + player_view_radius
				) and (
					spawn_position.y < target.position.y - player_view_radius
					or spawn_position.y > target.position.y + player_view_radius
				)):
			break
		spawn_try_count += 1
	var enemy_entity: EnemyEntity = enemy_scene.instantiate()
	enemy_entity.enemy_data = resource
	enemy_entity.target = target
	get_tree().current_scene.add_child(enemy_entity)
	enemy_entity.global_position = spawn_position
	return enemy_entity
