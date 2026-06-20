class_name DealDamage
extends HitEffect

@export var damage : int = 1

func apply(_bullet: BulletEntity, enemy: EnemyEntity) -> void:
	enemy.take_damage(damage)
