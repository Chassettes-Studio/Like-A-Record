class_name AddedSpreadAngleEffect
extends GunEffect

@export_range(0, 360, 0.1, "radians_as_degrees") var added_spread_angle: float = 0


func apply(gun: Gun) -> void:
	gun.spread_angle += added_spread_angle
