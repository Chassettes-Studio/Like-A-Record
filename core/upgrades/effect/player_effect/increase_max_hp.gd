class_name IncreaseMaxHp
extends PlayerEffect

@export var amount: int = 1

func apply(player: Player) -> void:
	player.health_controller.base_health += amount
	player.health_controller.heal(amount)
