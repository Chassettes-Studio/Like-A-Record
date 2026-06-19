class_name FeurAttack
extends EnemyAttack

@export var cooldown: float = 1

var time_since_last_attack: float = 0


func attack(delta: float) -> void:
	time_since_last_attack += delta
	if time_since_last_attack >= cooldown:
		time_since_last_attack -= cooldown
		print("FEUR")
