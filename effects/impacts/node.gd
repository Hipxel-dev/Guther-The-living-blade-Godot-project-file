extends Node2D

func _ready() -> void:
	$sprite.frame = 0
	$sprite.speed_scale = rand_range(5, 7)



func _on_sprite_animation_finished() -> void:
	queue_free()
