extends AnimatedSprite


func _ready() -> void:
	frame = 0


func _on_bloodsplashmassive_animation_finished() -> void:
	queue_free()
