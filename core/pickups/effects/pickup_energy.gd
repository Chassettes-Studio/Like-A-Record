class_name PickupEnergy
extends PickupEffect

@export var energy : int = 1

func apply(player: Player) -> void:
	player.energy = min(3, player.energy + energy)
