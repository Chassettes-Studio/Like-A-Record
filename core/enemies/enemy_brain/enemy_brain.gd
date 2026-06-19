@abstract
class_name EnemyBrain
extends Resource

var target: Node2D
var movement_controller: SCMovementController
var entity: EnemyEntity
var attack: EnemyAttack


@abstract func process(delta: float) -> void
