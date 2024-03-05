extends Sprite

var lifetiem = 0.1

func _physics_process(delta: float) -> void:
	lifetiem -= delta
	
	scale.y /= 2
	
	if lifetiem < 0:
		queue_free()
