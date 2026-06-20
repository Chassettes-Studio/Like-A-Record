class_name DamageArea
extends TogglableArea2D

@export var damage: float = 10

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	
func _on_area_entered(area: Area2D) -> void:
	var hitbox := area as Hitbox
	if hitbox:
		hitbox.damage(damage)
