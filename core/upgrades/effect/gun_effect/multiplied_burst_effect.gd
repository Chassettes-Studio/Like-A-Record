class_name MultipliedBurstEffect
extends GunEffect

@export var multiplied_burst: float = 1


func apply(gun: Gun) -> void:
	gun.burst *= multiplied_burst
