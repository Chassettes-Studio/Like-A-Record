class_name ApplyKnockback
extends HitEffect

@export var force := 200.0
@export var duration := 0.1

func apply(bullet: BulletEntity, enemy: EnemyEntity) -> void:
	var direction := bullet.global_position.direction_to(enemy.global_position)
	enemy.movement_controller.apply_knockback(force * direction, duration)
