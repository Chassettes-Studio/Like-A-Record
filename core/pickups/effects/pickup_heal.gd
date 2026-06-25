class_name PickupHeal
extends PlayerEffect

@export var health : int = 1

func apply(player: Player) -> void:
	player.health_controller.heal(health)
