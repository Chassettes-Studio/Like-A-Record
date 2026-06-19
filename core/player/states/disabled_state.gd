class_name DisabledState
extends State


func _init(target: Player) -> void:
	self.target = target


func on_enter() -> void:
	target.sc_physics_controller.set_physics_process(false)


func on_exit() -> void:
	target.sc_physics_controller.set_physics_process(true)


func physics_process(delta: float) -> void:
	pass
