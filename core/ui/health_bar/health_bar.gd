class_name HealthBar
extends MarginContainer

var original_bar_size: float

@onready var health_bar: ColorRect = $Control/Health
@onready var health_bar_shadow: ColorRect = $Control/Shadow


func _ready() -> void:
	original_bar_size = size.x
	health_bar.size.x = original_bar_size
	health_bar_shadow.size.x = original_bar_size


func take_hit(max_health: int, current_health: int) -> void:
	var new_size: float = current_health * original_bar_size / max_health
	var n: Vector2 = Vector2(new_size, health_bar.size.y)

	var tween_health: Tween = create_tween()
	tween_health.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween_health.tween_property(health_bar, "size", n, 0.2)

	await get_tree().create_timer(0.5).timeout

	var tween_shadow: Tween = create_tween()
	tween_shadow.tween_property(health_bar_shadow, "size", n, 0.2)
