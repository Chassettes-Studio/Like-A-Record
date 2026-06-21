class_name ReduceCooldown
extends GunEffect

@export var reduction: float = 0.1


func apply(gun: Gun) -> void:
	gun.shooting_cooldown -= reduction
