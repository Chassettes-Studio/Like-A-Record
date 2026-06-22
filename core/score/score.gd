extends Node

var score: int = 0
var wave: int = 1

signal score_changed

func reset() -> void:
	score = 0
	wave = 1

func add_score(value: int) -> void:
	score += value
	score_changed.emit()

func get_score() -> int:
	return score

func set_wave(val: int) -> void:
	wave = val

func get_wave() -> int:
	return wave
