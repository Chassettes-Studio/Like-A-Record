class_name Freeze
extends HitEffect

@export var duration : int = 1

func apply(_bullet: BulletEntity, enemy: EnemyEntity) -> void:
	enemy.freeze(duration)
