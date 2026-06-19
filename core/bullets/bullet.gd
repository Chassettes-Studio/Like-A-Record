class_name Bullet
extends Resource

const entity_scene : PackedScene = preload("res://core/bullets/entity/bullet_entity.tscn")

static func create(bullet: Bullet) -> BulletEntity:
	var entity : BulletEntity = entity_scene.instantiate() as BulletEntity
	entity.bullet_data = bullet
	for effect : BulletEffect in bullet.bullet_effects:
		effect.apply(entity)
	return entity

@export var texture : Texture2D

@export var impact_effects: Array[ImpactEffect]
@export var bullet_effects: Array[BulletEffect]
