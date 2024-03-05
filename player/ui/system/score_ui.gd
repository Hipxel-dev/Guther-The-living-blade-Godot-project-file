extends Node2D

var last_score = global.score
var scale_spr = Vector2.ZERO

var value = 0

func _physics_process(delta: float) -> void:
	value += (global.score - value) * 0.5
	
	scale_spr = lerp(scale_spr, (Vector2(144,-2) - $scoretext.rect_position) * 2, 0.3)
	$scoretext.rect_position += scale_spr
	
#	if $scoretext.rect_position.x < 143:
#		$scoretext.rect_position.x = 143
	global.ui_score_box_pos = global.camera_pos + Vector2(129,-60)
	
	if last_score != global.score:
		if global.score > last_score + 100:
			$scoretext.rect_position.x += 4
		$scoretext.rect_position += Vector2(1, 0)
		last_score = global.score
	
	$scoretext.text = str(round(value))
