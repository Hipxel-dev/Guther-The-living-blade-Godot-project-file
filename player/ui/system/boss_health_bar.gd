extends CanvasLayer

var delay = 0.3

func _physics_process(delta: float) -> void:
	delay -= delta
	if delay < 0:
		if $ui_component/health_bar.value <= 0:
			queue_free()
