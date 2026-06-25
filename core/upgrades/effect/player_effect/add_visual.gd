
class_name AddVisual
extends PlayerEffect

@export var texture: Texture2D
@export var behind_player: bool = false
@export var scale: Vector2 = Vector2.ONE

func apply(player: Player) -> void:
	var sprite: Sprite2D = Sprite2D.new()
	sprite.texture = texture.duplicate()
	player.player_sprite.add_child(sprite)
	sprite.global_position = player.global_position
	sprite.scale = scale
	if behind_player:
		sprite.z_index = player.player_sprite.z_index - 1
	else:
		sprite.z_index = player.player_sprite.z_index + 1
