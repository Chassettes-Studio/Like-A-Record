extends Node2D

@onready var spawner: Spawner = $Spawner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	print("spawn")
	spawner.spawn_enemy(preload("res://resources/enemies/feur.tres"))
