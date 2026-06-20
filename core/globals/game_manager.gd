extends Node

var enemy_alive_count: int = 0


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func increase_enemy_count() -> void:
	enemy_alive_count += 1


func decrease_enemy_count() -> void:
	enemy_alive_count -= 1
