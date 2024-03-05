extends AnimatedSprite

var movement = Vector2.ZERO
var magnetized = false

var lifetime = rand_range(10, 11)
var collect_sound = preload("res://sounds/effect_sounds/gold_get.wav")

var vel_y = rand_range(-100, -200)

onready var scenes = [$light, $light2, $light3]


func _physics_process(delta: float) -> void:
	
	
	
	
	lifetime -= delta
	position += movement * delta
	movement /= 1.1
	
	if lifetime < 0:
		queue_free()
		
	self_modulate = Color.white
	if position.distance_squared_to(global.player_pos) < 5000:
		magnetized = true
		
	if magnetized  and lifetime < 9.7:
		movement += (global.player_pos - position) * rand_range(0.2, 2)
		movement += Vector2(rand_range(-32,32), rand_range(-32,32))
		if position.distance_squared_to(global.player_pos) < 400:
			fx.sfx(collect_sound, position, rand_range(-10, 10),rand_range(0.9, 1.1))
			global.coin += 1
			queue_free()
