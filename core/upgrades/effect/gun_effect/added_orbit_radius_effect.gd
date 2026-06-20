class_name AddedOrbitRadiusEffect
extends GunEffect

@export var added_orbit_radius: float = 0


func apply(gun: Gun) -> void:
	gun.orbit_radius += added_orbit_radius
