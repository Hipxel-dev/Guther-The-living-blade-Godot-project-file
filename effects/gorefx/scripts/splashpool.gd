extends Sprite

func _ready() -> void:
	scale  *= rand_range(0, 1)
	modulate = Color8(rand_range(50, 60), 0,0)

func _on_Timer_timeout() -> void:
	queue_free()
