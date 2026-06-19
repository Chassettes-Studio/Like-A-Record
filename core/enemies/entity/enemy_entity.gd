class_name EnemyEntity
extends CharacterBody2D

@export var enemy_data: Enemy

@export var target: Node2D

@onready var movement_controller: SCPhysicsController = $SCPhysicsController
@onready var sprite: Sprite2D = $Sprite
@onready var name_label: Label = $NameLabel

var attack : EnemyAttack
var brain : EnemyBrain


func _ready() -> void:
	sprite.texture = enemy_data.texture
	name_label.text = enemy_data.name
	attack = enemy_data.attack.duplicate()
	brain = enemy_data.brain.duplicate()

func _physics_process(delta: float) -> void:
	brain.process(self, delta)
