extends CanvasLayer

@onready var health_bar: HealthBar = $MarginContainer/HBoxContainer/HealthBar


func _on_button_pressed() -> void:
	health_bar.take_hit(100, 1)
