class_name Player
extends CharacterBody2D

@export var DASH_SPEED: float = 5_000
@export var DASH_ACCELERATION: float = 50_000

var current_state: State = MovingState.new(self)

@onready var sc_physics_controller: SCPhysicsController = $SCPhysicsController
@onready var dash_cooldown: Timer = $DashCooldown
@onready var gun: Gun = $Gun


func _physics_process(delta: float) -> void:
	current_state.physics_process(delta)


func update_current_state(state: State) -> void:
	self.current_state.on_exit()
	self.current_state = state
	self.current_state.on_enter()
