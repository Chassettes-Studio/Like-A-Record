extends Node

var score: int = 0
var hs: int = 0
var wave: int = 1

signal score_changed

const score_path : String = "user://likearecordscore.txt"

func _ready() -> void:
	var file := FileAccess.open(score_path, FileAccess.READ_WRITE)
	if not file:
		print(FileAccess.get_open_error()) 
		return
	hs = file.get_32()
	file.close()

func reset() -> void:
	if score > hs:
		hs = score
	score = 0
	wave = 1
	
	
	var file := FileAccess.open(score_path, FileAccess.WRITE)
	if not file: return
	file.store_32(hs)
	file.close()

func add_score(value: int) -> void:
	score += value
	score_changed.emit()

func get_score() -> int:
	return score

func set_wave(val: int) -> void:
	wave = val

func get_wave() -> int:
	return wave
