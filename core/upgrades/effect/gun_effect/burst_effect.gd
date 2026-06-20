class_name BurstEffect
extends GunEffect

@export var added_burst: float = 0


func apply(gun: Gun) -> void:
	gun.burst += added_burst
