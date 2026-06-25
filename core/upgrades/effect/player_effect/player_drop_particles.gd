class_name PlayerDropParticles
extends PlayerEffect

@export var scene : PackedScene

func apply(player: Player) -> void:
	var particles := scene.instantiate() as GPUParticles2D
	player.get_tree().current_scene.add_child(particles)
	particles.global_position = player.global_position
	particles.finished.connect(particles.queue_free)
	particles.restart()
