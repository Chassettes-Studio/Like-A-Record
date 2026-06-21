extends Node

var score: int = 0

signal score_changed

func reset() -> void:
	score = 0

func add_score(value: int) -> void:
	score += value
	score_changed.emit()

func get_score() -> int:
	return score
