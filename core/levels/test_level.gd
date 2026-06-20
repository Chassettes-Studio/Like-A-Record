extends Node2D

var enemy_spawned_count: int = 0

@onready var spawner: Spawner = $Spawner
@onready var wave_manager: WaveManager = $WaveManager


func _on_timer_timeout() -> void:
	if enemy_spawned_count < wave_manager.total_enemy_count:
		spawner.spawn_enemy(wave_manager.get_random_enemy())
		enemy_spawned_count += 1


func _on_wave_manager_trigger_new_wave() -> void:
	enemy_spawned_count = 0
	wave_manager.next_wave()


func _on_spawner_new_enemy_spawned(enemy: EnemyEntity) -> void:
	wave_manager.increase_enemy_count()
	enemy.died.connect(wave_manager.decrease_enemy_count)
