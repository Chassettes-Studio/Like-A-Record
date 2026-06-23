## Health Controller
class_name SCHealthController
extends Node

## emitted after taking enough damages to be killed (can be emitted at the same time as died)
signal died
## emitted after taking damages
signal damaged
## emitted after being healed
signal healed
## emitted after being fully healed (can be emitted at the same time as healed)
signal fully_healed

## max health, cannot be exceeds
@export var base_health: int

## current health
var _health: int


func _ready() -> void:
	_health = base_health


## return health
func get_health() -> int:
	return _health


## return wether is dead or not
func is_dead() -> bool:
	return _health <= 0


## deal [amount] of damage to health and emit died if it kills
func take_damage(amount: int) -> void:
	_health -= amount
	damaged.emit()
	if is_dead():
		died.emit()


## heal [amount] health and emit fully_healed if it fully heals
func heal(amount: int) -> void:
	_health += amount
	if _health > base_health:
		_health = base_health
		fully_healed.emit()
	else:
		healed.emit()
