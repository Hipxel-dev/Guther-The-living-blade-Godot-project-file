extends KinematicBody2D

var sprite_vmov = 0
var movement = Vector2.ZERO

onready var sprite = $sprite
onready var shadow = $shadow

func _ready() -> void:
	$sprite/blood.emitting = true
	$sprite.frame = floor(rand_range(0, 9.99))
	$shadow.frame = $sprite.frame
#	var colorscale = rand_range(0.3, 2)
#	modulate = Color8(255,255 * colorscale, 255 * colorscale) 

	
	movement = Vector2(rand_range(-80,80), rand_range(-80,80)) 
	sprite_vmov = rand_range(-350, -100)
#	z_index = round(rand_range(-0.5, 1.9))

func _physics_process(delta):
	sprite.position.y += sprite_vmov * (delta / 2)
	
#	movement += Vector2(rand_range(-32,32), rand_range(-32,32))
#	movement += (global.player_pos - position) * 0.1
#
#	sprite.rotation_degrees += movement.x 
#	shadow.rotation_degrees = sprite.rotation_degrees
	
	shadow.position.y = (-sprite.position.y / 2) 
	
	sprite_vmov += 10
	if sprite.position.y > -1:
		sprite.position.y = 0
		movement /= 4
		if sprite_vmov > 200:
			fx.spwn_blood_pool_quick(position)
			$bounce_sfx.play()
		sprite_vmov = -sprite_vmov / 1.5
	
	move_and_slide(movement)


func _on_timer_timeout() -> void:
	queue_free()
