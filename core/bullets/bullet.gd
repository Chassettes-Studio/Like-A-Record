class_name Bullet
extends Resource

const entity_scene: PackedScene = preload("res://core/bullets/entity/bullet_entity.tscn")

@export var texture: Texture2D
@export var size: float = 100
@export var color: Color

@export var collision_effects: Array[CollisionEffect]
@export var bullet_effects: Array[BulletEffect]
@export var hit_effects: Array[HitEffect]


static func create(parent: Node, bullet: Bullet, is_enemy_bullet: bool = false) -> BulletEntity:
	var entity: BulletEntity = entity_scene.instantiate() as BulletEntity
	print(bullet)
	entity.bullet_data = bullet.duplicate()
	parent.add_child(entity)
	for effect: BulletEffect in bullet.bullet_effects:
		effect.apply(entity)
	if is_enemy_bullet:
		entity.area_2d.collision_mask = 1
	else:
		entity.area_2d.collision_mask = 2
	return entity
