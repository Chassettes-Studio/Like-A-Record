class_name AppendScene
extends EnemySpawnEffect

@export var scene : PackedScene

func apply(entity: EnemyEntity) -> void:
	entity.add_child(scene.instantiate())
