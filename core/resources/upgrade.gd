@abstract
class_name Upgrade
extends Resource

enum TYPE {
	GUN,
	BULLET,
	PLAYER,
	IMPACT,
}

@export var name: String
@export var description: String
@export var sprite: CompressedTexture2D

@export var type: TYPE

var player: Node2D #TODO

@abstract
func apply_upgrade_to_gun() -> void

@abstract
func apply_upgrade_to_bullet(bullet: Node2D) -> void  #TODO

@abstract
func apply_upgrade_to_impact(collider: Node2D) -> void

@abstract
func apply_upgrade_to_player() -> void
