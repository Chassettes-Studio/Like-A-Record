class_name HealAbility
extends AbilityEffect

@export var amount : int = 2

func use(player: Player) -> void:
	player.health_controller.heal(amount)
