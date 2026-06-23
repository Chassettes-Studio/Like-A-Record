class_name AlternateColor
extends BulletProcessEffect

@export var colors: Array[Color]
@export var loop: bool = true
@export var transition_delay: float = true

var current_color_idx: int = 0
var elapsed_time: float = 0
var temp_modulate: Color
var init: bool = false
var continue_transition: bool = true


func process(entity: BulletEntity, delta: float) -> void:
	if not init:
		init = true
		temp_modulate = entity.sprite.modulate
	elapsed_time += delta / transition_delay
	entity.sprite.modulate = lerp(entity.sprite.modulate, colors[current_color_idx], elapsed_time)
	if continue_transition and elapsed_time > transition_delay:
		elapsed_time -= transition_delay
		current_color_idx = (current_color_idx + 1)%colors.size()
	if not loop and current_color_idx == colors.size()-1:
		continue_transition = false
