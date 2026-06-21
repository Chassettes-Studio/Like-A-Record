class_name KamikazeBrain
extends EnemyBrain

@export var explosion_triggered_distance: float = 200
@export var explosion_delay: float = 3
@export var attack: EnemyDiscreteAttack

var is_explosion_triggered: bool = false
var has_exploded: bool = false


func process(entity: EnemyEntity, _delta: float) -> void:
	if entity.global_position.distance_to(entity.target.global_position) < explosion_triggered_distance and not is_explosion_triggered:
		entity.get_tree().create_timer(explosion_delay).timeout.connect(_trigger_action)
		is_explosion_triggered = true
	if has_exploded:
		attack.attack(entity)
	if is_explosion_triggered:
		entity.sprite.modulate = Color.RED
	entity.movement_controller.direction = entity.global_position.direction_to(entity.target.global_position)


func _trigger_action() -> void:
	has_exploded = true
