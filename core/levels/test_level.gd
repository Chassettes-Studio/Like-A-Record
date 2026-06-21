extends Node2D


@onready var player: Player = $Player

@onready var spawner: Spawner = $Spawner
@onready var wave_manager: WaveManager = $WaveManager

const upgrade_scene : PackedScene = preload("res://core/ui/upgrade/upgrade_selection.tscn")

func _on_timer_timeout() -> void:
	if wave_manager.left_to_spawn > 0:
		spawner.spawn_enemy(wave_manager.get_random_enemy())
		wave_manager.left_to_spawn -= 1


func _on_wave_manager_trigger_new_wave() -> void:
	var upgrade_selection : UpgradeSelector = upgrade_scene.instantiate()
	var upgrades := UpgradeManager.pick_upgrades()
	add_child(upgrade_selection)
	upgrade_selection.init(upgrades[0],upgrades[1],upgrades[2])
	
	var new_upgrade : Upgrade = await upgrade_selection.upgrade_chosen
	player.apply_upgrade(new_upgrade)
	UpgradeManager.upgrade_chosen(new_upgrade)
	wave_manager.next_wave()


func _on_spawner_new_enemy_spawned(enemy: EnemyEntity) -> void:
	enemy.died.connect(wave_manager.enemy_killed)
