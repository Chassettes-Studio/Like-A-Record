class_name AttachScene
extends BulletEffect

@export var scene: PackedScene

func apply(entity: BulletEntity) -> void:
	entity.add_child(scene.instantiate())
