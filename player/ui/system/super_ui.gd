extends Node2D

var tex = preload("res://art/player_art/ui_super.png")

# Amplitude and frequency parameters for the wave effect
var amplitude = 1
var frequency = 5

func _draw() -> void:
	for i in range(global.super):
		var y = amplitude * sin(i * frequency + OS.get_ticks_msec() * 0.01)
		draw_texture(tex, Vector2(i * 10, y))

func _physics_process(delta: float) -> void:
	update()
	if global.super > 6:
		global.super = 6

