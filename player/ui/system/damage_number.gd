extends Node2D

var vel = Vector2(rand_range(-70,70), rand_range(-400,-100))
var lifetime = 2

var number = 0

var blink = 0
var blink_intrvl = 0.03

func _ready() -> void:
	$text.text = str(number)
	scale *= countZerosInInteger(number)

func _physics_process(delta: float) -> void:
	lifetime -= delta
	position += vel * delta
	vel /= 1.09
#	vel.y += 3
	blink += delta
	
	if blink > 1.6:
		blink_intrvl -= delta
		if blink_intrvl <= -0.03:
			blink_intrvl = 0.03
		if blink_intrvl <= 0:
			modulate = Color8(0,0,0,0)
		else:
			modulate = Color.white
	else:
		modulate = Color.white
	
	scale = scale.linear_interpolate(Vector2(1,1), delta * 5)
	if lifetime < 0:
		queue_free()
	
	
func countZerosInInteger(value: int) -> int:
	var zeroCount = 0
	var valueString = str(value)
	
	for i in range(valueString.length()):
		if valueString[i] == "0":
			zeroCount += 2
	
	return zeroCount
