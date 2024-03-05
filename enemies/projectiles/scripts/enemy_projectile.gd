extends Area2D

var movement = Vector2.ZERO
var health = 1


func _physics_process(delta: float) -> void:
	position += movement * delta
	

func _on_Timer_timeout() -> void:
	queue_free()
