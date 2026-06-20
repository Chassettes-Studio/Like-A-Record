class_name AddedProjectileCountEffect
extends GunEffect

@export var added_projectile_count: int = 0


func apply(gun: Gun) -> void:
	gun.projectile_count += added_projectile_count
