extends Sprite

var scale_downziser = rand_range(1, 1.02)

func _ready() -> void:
	scale *= rand_range(0, 0.2)
	modulate = Color8(rand_range(50, 60), 0,0)

func _physics_process(delta: float) -> void:
	scale = scale.linear_interpolate(Vector2(1,1), delta * 0.1)
	scale /= scale_downziser


func _on_timer_timeout() -> void:
	queue_free()
