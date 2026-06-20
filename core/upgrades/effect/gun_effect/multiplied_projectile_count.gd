class_name MultipliedProjectileCountEffect
extends GunEffect

@export var multiplied_projectile_count: int = 1


func apply(gun: Gun) -> void:
	gun.projectile_count *= multiplied_projectile_count
