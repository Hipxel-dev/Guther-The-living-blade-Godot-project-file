extends Node2D

func _physics_process(delta: float) -> void:
	$health_bar.value = global.health
	
