class_name GunAddChild
extends GunEffect

@export var scene : PackedScene

func apply(gun: Gun) -> void:
	gun.add_child(scene.instantiate())
