class_name DropPickup
extends EnemyDeath

const pickup_scene: PackedScene = preload("res://core/pickups/pickup_entity.tscn")

@export var drops: Dictionary[Pickup, float]


func get_drop() -> Pickup:
	var accum := randf()
	for i in drops.size():
		if drops.values()[i] > accum:
			return drops.keys()[i]
		accum -= drops.values()[i]
	return null


func apply(entity: EnemyEntity) -> void:
	var pickup := get_drop()
	if not pickup: return
	var pe : PickupEntity = pickup_scene.instantiate()
	pe.pickup = pickup
	entity.get_tree().current_scene.add_child.call_deferred(pe)
	pe.global_position = entity.global_position
	
