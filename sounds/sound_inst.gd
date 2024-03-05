extends AudioStreamPlayer2D



func _on_sound_inst_finished() -> void:
	queue_free()
