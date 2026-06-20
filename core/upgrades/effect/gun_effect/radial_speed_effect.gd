class_name RadialSpeedEffect
extends GunEffect

@export var added_radial_speed: float = 0


func apply(gun: Gun) -> void:
	gun.radial_speed += added_radial_speed
