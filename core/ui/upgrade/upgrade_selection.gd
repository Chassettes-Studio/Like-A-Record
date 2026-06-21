class_name UpgradeSelector
extends CanvasLayer

signal upgrade_chosen(upgrade: Upgrade)

@onready var card1: UpgradeCard = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/UpgardeCard
@onready var card2: UpgradeCard = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/UpgardeCard2
@onready var card3: UpgradeCard = $MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/UpgardeCard3

@onready var bg: ColorRect = $ColorRect
@onready var title: Label = $MarginContainer/VBoxContainer/Label
@onready var insert_disc: AudioStreamPlayer = $InsertDisc

func _ready() -> void:
	spawn()
	get_tree().paused = true


func spawn() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(card1, "offset_transform_position", Vector2(0.0, 30.0), 0.4)
	tween.tween_property(card2, "offset_transform_position", Vector2(0.0, 0.0), 0.4)
	tween.tween_property(card3, "offset_transform_position", Vector2(0.0, 30.0), 0.4)
	tween.tween_property(bg.material, "shader_parameter/spread", 0.4, 1)


func init(upgrade1: Upgrade, upgrade2: Upgrade, upgrade3: Upgrade) -> void:
	card1.init(upgrade1)
	card2.init(upgrade2)
	card3.init(upgrade3)
	AudioServer.set_bus_effect_enabled(1,0,true)

func _on_upgarde_card_free() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(true).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(card1, "offset_transform_position", Vector2(0.0, 1000.0), 0.4)
	tween.tween_property(card2, "offset_transform_position", Vector2(0.0, 1000.0), 0.4)
	tween.tween_property(card3, "offset_transform_position", Vector2(0.0, 1000.0), 0.4)
	tween.tween_property(bg.material, "shader_parameter/spread", 0.01, 1)
	await get_tree().create_timer(1).timeout
	get_tree().paused = false
	AudioServer.set_bus_effect_enabled(1,0,false)
	queue_free()


func _on_upgarde_card_upgrade_chosen(upgrade: Upgrade) -> void:
	insert_disc.play()
	upgrade_chosen.emit(upgrade)
