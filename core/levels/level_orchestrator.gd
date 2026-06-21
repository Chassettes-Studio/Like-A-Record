class_name LevelOrchestrator
extends Node

@export var spawn_interval : float = 1

@export var audio_player: AudioStreamPlayer
@export var player: Player
@export var spawner: Spawner
@export var wave_manager: WaveManager

var spawn_timer: Timer

const upgrade_scene : PackedScene = preload("res://core/ui/upgrade/upgrade_selection.tscn")

func _ready() -> void:
	_create_timer()
	_connect_signals()
	audio_player.stream = player.character.intro_song
	audio_player.play()
	audio_player.finished.connect(_start_music_loop)
	
func _start_music_loop() -> void:
	audio_player.stream = player.character.loop_song
	audio_player.play()
	
func _connect_signals() -> void:
	wave_manager.trigger_new_wave.connect(_on_wave_manager_trigger_new_wave)
	spawner.new_enemy_spawned.connect(_on_spawner_new_enemy_spawned)
	
func _create_timer() -> void:
	spawn_timer = Timer.new()
	spawn_timer.autostart = false
	spawn_timer.one_shot = false
	spawn_timer.timeout.connect(_on_timer_timeout)
	add_child(spawn_timer)
	spawn_timer.start(spawn_interval)

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
