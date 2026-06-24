class_name AbilityShoot
extends AbilityEffect

@export var bullet : Bullet

func use(player: Player) -> void:
	var be := Bullet.create(player.get_tree().current_scene,bullet)
	be.global_position = player.global_position
	be.bullet_controller.direction = Vector2.RIGHT.rotated(player.gun.rotation)
