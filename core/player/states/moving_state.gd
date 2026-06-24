class_name MovingState
extends State

var last_direction: Vector2 = Vector2.RIGHT


func _init(new_target: Player, new_last_direction: Vector2) -> void:
	self.target = new_target
	self.last_direction = new_last_direction


func on_enter() -> void:
	pass


func on_exit() -> void:
	pass


func physics_process(_delta: float) -> void:
	target.sc_physics_controller.direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if target.sc_physics_controller.direction.x != 0 or target.sc_physics_controller.direction.y != 0:
		last_direction = target.sc_physics_controller.direction
	if target.dash_cooldown.is_stopped() and Input.is_action_just_pressed("dash") and target.dash_unlocked:
		target.dash_cooldown.start()
		target.update_current_state(DashingState.new(
			target,
			last_direction,
			target.dash_duration
		))
