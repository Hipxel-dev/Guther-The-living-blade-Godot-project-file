extends Sprite


func _ready() -> void:
	modulate = Color8(rand_range(50, 60), 0,0)

func _on_timer_timeout() -> void:
	queue_free()
