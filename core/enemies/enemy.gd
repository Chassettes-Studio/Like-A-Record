class_name Enemy
extends Resource

@export var name: String
@export var texture: Texture2D

@export var shape : Shape2D = CircleShape2D.new()
@export var attack: EnemyAttack
@export var brain: EnemyBrain
