extends Node2D

@onready var spawner: Spawner = $Spawner
@onready var wave_manager: WaveManager = $WaveManager

var enemy_spawned_count: int = 0

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	if enemy_spawned_count < wave_manager.total_enemy_count:
		print("spawn")
		spawner.spawn_enemy(wave_manager.get_random_enemy())
		enemy_spawned_count += 1


func _on_wave_manager_trigger_new_wave() -> void:
	enemy_spawned_count = 0
	wave_manager.next_wave()
