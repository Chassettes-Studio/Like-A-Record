class_name DieOnContact
extends EnemyContact

func apply(entity: EnemyEntity, player: Player) -> void:
	if player.invulnerability_timer.is_stopped():	entity.die()
