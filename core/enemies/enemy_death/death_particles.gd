class_name SpawnOnDeath
extends EnemyDeath

@export var scene : PackedScene

func apply(entity : EnemyEntity) -> void:
	var instance := scene.instantiate()
	
	var node2d := instance as Node2D
	if node2d:	node2d.global_position = entity.global_position
	
	var particles := instance as GPUParticles2D
	if particles: 
		particles.finished.connect(particles.queue_free)
		particles.restart()
	
	entity.get_tree().current_scene.add_child(instance)
