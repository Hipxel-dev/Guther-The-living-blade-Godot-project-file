extends AnimatedSprite

func _ready() -> void:
	look_at(global.player_pos)
	frame = 0
	
	


func _on_bloodsplashdirectional_animation_finished() -> void:
	queue_free()
