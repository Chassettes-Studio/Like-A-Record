class_name Enemy
extends Resource

@export var name: String
@export var texture: Texture2D
@export var min_wave: int = 1
@export var weight: float = 1

@export var attack: EnemyAttack
@export var brain: EnemyBrain
