class_name SpreadAngleEffect
extends GunEffect

@export var added_spread_angle: float = 0


func apply(gun: Gun) -> void:
	gun.spread_angle += added_spread_angle
