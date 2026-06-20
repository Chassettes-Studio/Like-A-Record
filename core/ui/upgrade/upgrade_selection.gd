extends CanvasLayer

signal upgrade_chosen(upgrade: Upgrade)

@onready var card1: UpgradeCard
@onready var card2: UpgradeCard
@onready var card3: UpgradeCard


func init(upgrade1: Upgrade, upgrade2: Upgrade, upgrade3: Upgrade) -> void:
	card1.init(upgrade1)
	card2.init(upgrade2)
	card3.init(upgrade3)


func _on_upgarde_card_free() -> void:
	queue_free()


func _on_upgarde_card_upgrade_chosen(upgrade: Upgrade) -> void:
	upgrade_chosen.emit(upgrade)
