class_name MovingState
extends State


func _init(new_target: Player) -> void:
	self.target = new_target


func on_enter() -> void:
	pass


func on_exit() -> void:
	pass


func physics_process(_delta: float) -> void:
	target.sc_physics_controller.direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if target.dash_cooldown.is_stopped() and Input.is_action_just_pressed("dash"):
		target.dash_cooldown.start()
		target.update_current_state(DashingState.new(
			target,
			Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		))
