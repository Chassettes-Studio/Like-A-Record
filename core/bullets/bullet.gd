class_name Bullet
extends Resource

const entity_scene : PackedScene = preload("res://core/bullets/entity/bullet_entity.tscn")

static func create(parent: Node, bullet: Bullet, is_enemy_bullet : bool = false) -> BulletEntity:
	var entity : BulletEntity = entity_scene.instantiate() as BulletEntity
	entity.bullet_data = bullet
	for effect : BulletEffect in bullet.bullet_effects:
		effect.apply(entity)
	parent.add_child(entity)
	if is_enemy_bullet:
		entity.area_2d.collision_mask = 1
	else:
		entity.area_2d.collision_mask = 2
	return entity

@export var texture : Texture2D
@export var shape: Shape2D

@export var collision_effects: Array[CollisionEffect]
@export var bullet_effects: Array[BulletEffect]
@export var hit_effects: Array[HitEffect]
