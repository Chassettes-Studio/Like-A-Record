class_name LevelOrchestrator
extends Node

@export var spawn_interval : float = 1

@export var audio_player: AudioStreamPlayer
@export var player: Player
@export var wave_manager: WaveManager

var spawn_timer: Timer

const upgrade_scene : PackedScene = preload("res://core/ui/upgrade/upgrade_selection.tscn")

func _ready() -> void:
	Score.reset()
	_create_timer()
	_connect_signals()
	audio_player.stream = player.character.intro_song
	audio_player.play()
	audio_player.finished.connect(_start_music_loop)
	
func _start_music_loop() -> void:
	audio_player.stream = player.character.loop_song
	audio_player.play()
	
func _connect_signals() -> void:
	player.died.connect(_on_player_death)
	wave_manager.trigger_new_wave.connect(_on_wave_manager_trigger_new_wave)
	
func _create_timer() -> void:
	spawn_timer = Timer.new()
	spawn_timer.autostart = false
	spawn_timer.one_shot = false
	spawn_timer.timeout.connect(_on_timer_timeout)
	add_child(spawn_timer)
	spawn_timer.start(spawn_interval)

func _on_timer_timeout() -> void:
	wave_manager.try_spawn()

func _on_wave_manager_trigger_new_wave() -> void:
	var upgrade_selection : UpgradeSelector = upgrade_scene.instantiate()
	var upgrades := UpgradeManager.pick_upgrades()
	add_child(upgrade_selection)
	upgrade_selection.init(upgrades[0],upgrades[1],upgrades[2])
	var new_upgrade : Upgrade = await upgrade_selection.upgrade_chosen
	player.apply_upgrade(new_upgrade)
	player.health_controller.heal(1)
	UpgradeManager.upgrade_chosen(new_upgrade)
	spawn_timer.wait_time *= 0.9
	wave_manager.next_wave()

func _on_player_death() -> void:
	audio_player.stop()
