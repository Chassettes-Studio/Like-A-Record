@abstract class_name State
extends RefCounted

var target: Player


@abstract func on_enter() -> void


@abstract func on_exit() -> void


@abstract func physics_process(delta: float) -> void
