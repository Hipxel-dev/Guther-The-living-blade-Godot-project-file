extends Node2D

func _physics_process(delta: float) -> void:
	$coin_text.text = str(global.coin)
