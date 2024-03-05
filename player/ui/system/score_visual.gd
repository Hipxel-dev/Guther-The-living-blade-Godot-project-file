extends Node2D

var score = 0

var lifetime = 2

var blink = 0.3
var blink_intrvl = 0.03


var init_score = true

func _ready() -> void:
	$text.text = str(score)

#	scale += Vector2(global.player_damage, global.player_damage) / 50
	
func _physics_process(delta: float) -> void:
#	global_position.x = clamp(global_position.x, global.camera_pos.x - 130, global.camera_pos.x + 130)
#	global_position.y = clamp(global_position.y, global.camera_pos.y - 56, global.camera_pos.y + 56)
	
	if init_score:
		scale *= 1 + countZerosInInteger(score)
		init_score = false
	
	if blink > 0:
		blink -= delta
		blink_intrvl -= delta
		if blink_intrvl <= -0.03:
			blink_intrvl = 0.03
		if blink_intrvl <= 0:
			modulate = Color8(0,0,0,0)
		else:
			modulate = Color.white
	else:
		modulate = Color.white
		
	scale = scale.linear_interpolate(Vector2(1,1), delta * 23.6)
	

	lifetime -= delta
#	if lifetime < 1:
#		position = (global.ui_score_box_pos - position).normalized() * 300
		
	if lifetime < 0:
		queue_free()
		

func countZerosInInteger(value: int) -> int:
	var zeroCount = 0
	var valueString = str(value)
	
	for i in range(valueString.length()):
		if valueString[i] == "0":
			zeroCount += 1
	
	return zeroCount
