class_name ReduceCooldown
extends GunEffect

@export_range(0,100,1,"suffix:%") var reduction: float = 20


func apply(gun: Gun) -> void:
	gun.shooting_cooldown *= (1 - reduction)
