extends Node2D

var last_value = global.energy

func _physics_process(delta: float) -> void:
	if last_value != global.energy:
		$power_bar.rect_scale = Vector2(1.3,1.3)
		last_value = global.energy
	
	$power_bar.rect_scale = $power_bar.rect_scale.linear_interpolate(Vector2(1,1), delta * 25)
	$power_bar.rect_position.x = global.super * 10
	$power_bar.value = global.energy
	
	if global.super < 0:
		global.super = 0
	if global.energy >= 100:
		global.energy = 0
		global.super += 1
		$power_bar.value = 0
