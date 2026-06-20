class_name MultipliedOrbitRadiusEffect
extends GunEffect

@export_range(0, 360, 0.1, "radians_as_degrees") var multiplied_orbit_radius: float = 1


func apply(gun: Gun) -> void:
	gun.orbit_radius *= multiplied_orbit_radius
