extends Node


func _physics_process(delta: float) -> void:
	if Engine.time_scale != 1:
		yield(get_tree().create_timer(0.02), "timeout")
		Engine.time_scale = 1
