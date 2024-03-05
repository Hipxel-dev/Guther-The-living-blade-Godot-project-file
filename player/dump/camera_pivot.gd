extends Camera2D

func _physics_process(delta: float) -> void:
	
	
	global.camera_pos = global_position
	
	if global.player_alive:
		position = position.linear_interpolate(global.player_pos + get_local_mouse_position() , delta * 3)
	
#	$camera_view.position = Vector2(cos(global.shake), sin(global.shake)) 
#
	$camera_view.position = Vector2(rand_range(-1,1), rand_range(-1,1)).normalized() * global.shake
	global.shake /= 1.4
	
