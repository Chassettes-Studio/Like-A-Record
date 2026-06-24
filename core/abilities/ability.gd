class_name Ability
extends Resource

@export var effects: Array[PlayerEffect]

func use(player: Player) -> void:
	for effect in effects:
		effect.apply(player)
