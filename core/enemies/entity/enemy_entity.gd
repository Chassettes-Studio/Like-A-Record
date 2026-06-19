class_name EnemyEntity
extends CharacterBody2D

@export var enemy_data: Enemy

@export var target: Node2D

@onready var movement_controller: SCPhysicsController = $SCPhysicsController
@onready var sprite: Sprite2D = $Sprite
@onready var name_label: Label = $NameLabel


func _ready() -> void:
	sprite.texture = enemy_data.texture
	name_label.text = enemy_data.name

	enemy_data.setup(self, target, movement_controller)


func _physics_process(delta: float) -> void:
	enemy_data.brain.process(delta)
