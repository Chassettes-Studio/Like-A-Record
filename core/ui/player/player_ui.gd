class_name PlayerUi
extends CanvasLayer

@onready var health_bar: HealthBar = $HealthBar
@onready var cd_sprite: TextureRect = $Cd

@onready var upgrade_container: HBoxContainer = $MarginContainer/HBoxContainer
@onready var score_label: Label = $Score
@onready var wave_label: Label = $Wave

var upgrade_mini: PackedScene = preload("res://core/ui/upgrade/UpgradeMini.tscn")

func _ready() -> void:
	Score.score_changed.connect(_on_score_changed)

func _process(_delta: float) -> void:
	cd_sprite.offset_transform_rotation += 0.05

func _on_score_changed() -> void:
	var c: int = int(score_label.text)
	var n: int = (Score.get_score() - c) / 7. as int
	for i in n :
		score_label.text = str(c + 7*i)
		await get_tree().create_timer(0.035).timeout
	score_label.text = str(Score.get_score())

func take_damage(max_health: int, current_health: int) -> void:
	health_bar.take_hit(max_health, current_health)

func update_upgrade(upgrades: Array[Upgrade]) -> void:
	wave_label.text = "Wave " + str(Score.wave + 1)
	for child in upgrade_container.get_children():
		upgrade_container.remove_child(child)
	for up in upgrades:
		var instance: UpgradeMini = upgrade_mini.instantiate()
		upgrade_container.add_child(instance)
		instance.init(up)
