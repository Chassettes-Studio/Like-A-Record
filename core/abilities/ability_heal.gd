class_name HealAbility
extends PlayerEffect

@export var amount : int = 2

func apply(player: Player) -> void:
	player.health_controller.heal(amount)
