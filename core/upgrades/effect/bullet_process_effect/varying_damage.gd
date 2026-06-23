class_name VaryingDamage
extends BulletProcessEffect

@export var damage_evolution_per_second: float = 1

func process(entity: BulletEntity, delta: float) -> void:
	entity.bullet_data
