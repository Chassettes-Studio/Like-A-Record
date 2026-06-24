class_name Spawner
extends Node2D

const enemy_scene: PackedScene = preload("res://core/enemies/entity/enemy_entity.tscn")
const marker_scene: PackedScene = preload("res://core/enemies/marker/SpawnMarker.tscn")

@export var target: Player
@export var top_left_corner: Vector2
@export var bottom_down_corner: Vector2
@export var player_view_radius: float
@export var player_view_radius_margin: float


func spawn_enemy(resource: Enemy) -> EnemyEntity:

	if not is_instance_valid(target): return

	var spawn_position: Vector2 = Vector2(0, 0)
	var angle: float = randf_range(0, TAU)
	var radius: float = randf_range(player_view_radius, player_view_radius + player_view_radius_margin)
	spawn_position = target.global_position + ((Vector2.RIGHT * radius).rotated(angle))
	spawn_position.x = clamp(spawn_position.x, top_left_corner.x, bottom_down_corner.x)
	spawn_position.y = clamp(spawn_position.y, top_left_corner.y, bottom_down_corner.y)
	var enemy_entity: EnemyEntity = enemy_scene.instantiate()
	enemy_entity.enemy_data = resource
	enemy_entity.target = target
	enemy_entity.global_position = spawn_position

	var marker: Marker = marker_scene.instantiate()
	marker.global_position = spawn_position
	marker.enemy = enemy_entity

	get_tree().current_scene.add_child(marker)
	return enemy_entity
