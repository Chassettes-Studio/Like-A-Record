class_name FasterMovement
extends PlayerEffect

@export var added_speed : float = 50

func apply(player: Player) -> void:
	player.sc_physics_controller.max_speed += added_speed
