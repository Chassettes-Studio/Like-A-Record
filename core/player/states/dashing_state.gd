class_name DashingState
extends State

var dash_direction: Vector2
var dash_duration: Timer


func _init(new_target: Player, direction: Vector2) -> void:
	self.target = new_target
	self.dash_direction = direction
	target.get_tree().create_timer(0.2).timeout.connect(_on_duration_end)


func on_enter() -> void:
	target.sc_physics_controller.set_physics_process(false)


func on_exit() -> void:
	target.sc_physics_controller.set_physics_process(true)
	target.velocity = dash_direction * target.sc_physics_controller.max_speed


func physics_process(delta: float) -> void:
	target.velocity = target.velocity.move_toward(target.DASH_SPEED * dash_direction, delta * target.DASH_ACCELERATION)
	target.move_and_slide()


func _on_duration_end() -> void:
	target.update_current_state(MovingState.new(target))
