class_name SingleShootAttack
extends EnemyDiscreteAttack

@export var bullet: Bullet
@export var v_gun: VirtualGun


func attack(enemy: EnemyEntity) -> void:
	v_gun.shoot(enemy.global_position.direction_to(enemy.target.global_position), enemy, bullet)
