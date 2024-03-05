extends Node2D

var combo = 0
var combo_duration = 6



func _physics_process(delta: float) -> void:
	$combo.text = str(combo)
	
	if global.for_combo_enemy_killed:
		combo += 1
		combo_duration = 5
		global.for_combo_enemy_killed = false
