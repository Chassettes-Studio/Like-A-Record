class_name SingleShootAttack
extends EnemyDiscreteAttack

@export var bullet: Bullet
@export var v_gun: VirtualGun


func attack(enemy: EnemyEntity) -> void:
	if not v_gun:
		v_gun = VirtualGun.new(enemy, bullet)
	v_gun.shoot(enemy.global_position.direction_to(enemy.target.global_position))
	#var entity := Bullet.create(enemy.get_tree().current_scene, bullet, true)
	#entity.global_position = enemy.global_position
	#entity.bullet_controller.direction = enemy.global_position.direction_to(enemy.target.global_position)
