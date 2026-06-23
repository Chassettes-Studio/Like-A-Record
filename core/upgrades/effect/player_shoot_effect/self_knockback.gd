class_name SelfKnockback
extends PlayerShootEffect

@export var force : float = 200
@export var duration : float = 0.1

func apply(player: Player) -> void:
	player.sc_physics_controller.apply_knockback(Vector2.LEFT.rotated(player.gun.rotation) * force, duration)
