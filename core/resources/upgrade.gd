@abstract
class_name Upgrade
extends Resource

@export var name: String
@export var description: String
@export var sprite: CompressedTexture2D

@export var bullet_effect: UpgradeEffect
@export var gun_effect: UpgradeEffect
@export var impact_effect: UpgradeEffect
@export var player_effect: UpgradeEffect

func apply_upgrade_to_gun() -> void:
	gun_effect.apply()

func apply_upgrade_to_bullet() -> void:
	bullet_effect.apply()

func apply_upgrade_to_impact() -> void:
	impact_effect.apply()

func apply_upgrade_to_player() -> void:
	player_effect.apply()
