extends Area2D

func _physics_process(delta: float) -> void:
	yield(get_tree().create_timer(0.05), "timeout")
	queue_free()
	
