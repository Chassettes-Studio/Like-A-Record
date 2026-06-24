class_name AbilityShoot
extends PlayerEffect

@export var bullet : Bullet

func apply(player: Player) -> void:
	var be := Bullet.create(player.get_tree().current_scene,bullet)
	be.global_position = player.global_position
	be.bullet_controller.direction = Vector2.RIGHT.rotated(player.gun.rotation)
