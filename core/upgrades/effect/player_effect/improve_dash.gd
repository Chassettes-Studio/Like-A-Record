class_name ImproveDash
extends PlayerEffect

@export var extra_speed : float = 0
@export_range(0,100,1,"suffix:%") var cd_reduction : float = 0

func apply(player: Player) -> void:
	player.dash_cooldown.wait_time *= (1 - .01 * cd_reduction)
	player.DASH_SPEED += extra_speed
