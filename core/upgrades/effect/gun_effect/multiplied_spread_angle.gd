class_name MultipliedSpreadAngleEffect
extends GunEffect

@export var multiplied_spread_angle: float = 0


func apply(gun: Gun) -> void:
	gun.spread_angle += multiplied_spread_angle
