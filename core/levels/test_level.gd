extends Node2D

var enemy_spawned_count: int = 0

@onready var player: Player = $Player

@onready var spawner: Spawner = $Spawner
@onready var wave_manager: WaveManager = $WaveManager

const upgrade_scene : PackedScene = preload("res://core/ui/upgrade/upgrade_selection.tscn")

func _on_timer_timeout() -> void:
	if enemy_spawned_count < wave_manager.total_enemy_count:
		spawner.spawn_enemy(wave_manager.get_random_enemy())
		enemy_spawned_count += 1


func _on_wave_manager_trigger_new_wave() -> void:
	enemy_spawned_count = 0
	var upgrade_selection : UpgradeSelector = upgrade_scene.instantiate()
	var upgrades := UpgradeManager.pick_upgrades()
	upgrade_selection.init(upgrades[0],upgrades[1],upgrades[2])
	add_child(upgrade_selection)
	
	var new_upgrade : Upgrade = await upgrade_selection.upgrade_chosen
	player.app
	wave_manager.next_wave()


func _on_spawner_new_enemy_spawned(enemy: EnemyEntity) -> void:
	wave_manager.increase_enemy_count()
	enemy.died.connect(wave_manager.decrease_enemy_count)
