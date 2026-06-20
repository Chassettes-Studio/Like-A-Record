extends Node2D

@onready var spawner: Spawner = $Spawner

func _on_timer_timeout() -> void:
	print("spawn")
	spawner.spawn_enemy(preload("res://resources/enemies/feur.tres"))
