class_name Ability
extends Resource

@export var effects: Array[AbilityEffect]

func use(player: Player) -> void:
	for effect in effects:
		effect.use(player)
