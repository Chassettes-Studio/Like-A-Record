class_name Enemy
extends Resource

@export var name: String
@export var texture: Texture2D

@export var attack: EnemyAttack
@export var brain: EnemyBrain


func setup(entity: EnemyEntity, target: Node2D, movement_controller: SCMovementController) -> void:
	brain.entity = entity
	brain.attack = attack
	brain.target = target
	brain.movement_controller = movement_controller
