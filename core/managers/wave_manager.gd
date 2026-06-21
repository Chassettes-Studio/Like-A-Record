class_name WaveManager
extends Node

signal trigger_new_wave

@export var spawner: Spawner

@export var total_enemy_count: int = 10

var enemies: Array[Enemy] = []
var killcount: int = 0
var left_to_spawn: int
var current_enemy_pool: Array[Enemy] = []
var current_wave: int = 1


func _ready() -> void:
	left_to_spawn = total_enemy_count
	var resources: PackedStringArray = ResourceLoader.list_directory("res://resources/enemies/")
	for resource in resources:
		enemies.append(load("res://resources/enemies/" + resource))
	create_enemy_pool()


func create_enemy_pool() -> void:
	current_enemy_pool.clear()
	current_enemy_pool = enemies.filter(func(e: Enemy) -> bool: return e.min_wave <= current_wave)


func next_wave() -> void:
	current_wave += 1
	Score.set_wave(current_wave)
	create_enemy_pool()
	killcount = 0
	total_enemy_count += current_wave
	left_to_spawn = total_enemy_count
	
func try_spawn() -> void:
	if left_to_spawn <= 0:
		return
	var enemy := get_random_enemy()
	spawner.spawn_enemy(enemy).died.connect(_on_enemy_death)
	left_to_spawn -= 1
	print("Spawn enemy, left ",left_to_spawn)

func _on_enemy_death() -> void:
	
	killcount += 1
	if killcount >= total_enemy_count:
		trigger_new_wave.emit()

func get_random_enemy() -> Enemy:
	var total_weight: float = current_enemy_pool.reduce(func(acc: float, e: Enemy) -> float: return acc + e.weight, 0)
	var choice: float = randf_range(0, total_weight)
	for enemy in current_enemy_pool:
		choice -= enemy.weight
		if choice <= 0:
			return enemy
	return current_enemy_pool[0]
