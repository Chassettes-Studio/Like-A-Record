class_name MultipliedRadialSpeedEffect
extends GunEffect

@export var multiplied_radial_speed: float = 0


func apply(gun: Gun) -> void:
	gun.radial_speed += multiplied_radial_speed
