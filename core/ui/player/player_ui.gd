class_name PlayerUi
extends CanvasLayer

@onready var health_bar: HealthBar = $MarginContainer/HBoxContainer/Control/HealthBar

func take_damage(max_health: int, current_health: int) -> void:
	health_bar.take_hit(max_health, current_health)
