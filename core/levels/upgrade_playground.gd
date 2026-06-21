extends Node2D

@export var upgrades: Array[Upgrade]
@onready var player: Player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for upgrade in upgrades:
		player.apply_upgrade(upgrade)
