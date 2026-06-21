class_name ShootAttack
extends EnemyContinuousAttack

@export var bullet : Bullet

@export var cooldown: float = 1

var time_since_last_attack: float = 0


func attack(delta: float, enemy: EnemyEntity) -> void:
	time_since_last_attack += delta
	if time_since_last_attack >= cooldown:
		time_since_last_attack -= cooldown
		var entity := Bullet.create(enemy.get_tree().current_scene, bullet, true)
		entity.global_position = enemy.global_position
		entity.bullet_controller.direction = enemy.global_position.direction_to(enemy.target.global_position)
