extends Node2D

@onready var player: Player = $Player

var upgrade_selector: PackedScene = preload("res://core/ui/upgrade/upgrade_selection.tscn")

func _on_enemy_entity_died() -> void:
	var instance: UpgradeSelector = upgrade_selector.instantiate()
	add_child(instance)


func _on_player_damaged() -> void:
	get_tree().call_deferred("reload_current_scene")
