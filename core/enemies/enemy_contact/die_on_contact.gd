class_name DieOnContact
extends EnemyContact

func apply(entity: EnemyEntity, -player: Player) -> void:
	entity.die()
