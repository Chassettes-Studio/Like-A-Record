class_name Marker
extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
var enemy: EnemyEntity

func _ready() -> void:
	await get_tree().create_timer(1.0).timeout
	var tween: Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(sprite_2d, "scale", Vector2(0.0, 0.0), 1.0)
	await get_tree().create_timer(1.0).timeout
	get_tree().current_scene.add_child(enemy)
	queue_free()
