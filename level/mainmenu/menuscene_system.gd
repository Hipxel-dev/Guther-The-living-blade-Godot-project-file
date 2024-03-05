extends Node2D

enum menu_states {
	PRESS_START,
	MAIN,
	PLAY,
	OPTIONS,
	EXTRAS,
	QUIT,
	SUB_PLAY_LEVEL_SELECT,
	SUB_CHAPTER_SELECT,
	SUB_OPTIONS_GAMEPLAY,
	
}

var current_menu_state = menu_states.PRESS_START

var slow_shake = 0

func _physics_process(delta: float) -> void:
	if $camera:
		$camera.position = Vector2(160, 90) + Vector2(rand_range(-global.shake, global.shake), rand_range(-global.shake, global.shake)) + Vector2(rand_range(-slow_shake, slow_shake), rand_range(-slow_shake, slow_shake))
		Engine.time_scale = 1
		if Input.is_action_just_pressed("CLICK"):
			for i in range(5):
				fx.spwn_slash_spark(get_global_mouse_position(), 1, Color8(rand_range(0, 100), 0,0))
				fx.spwn_impact_single(get_global_mouse_position(), rand_range(0.5, 1), rand_range(-320, 320), Color8(rand_range(0, 100), 0,0))
				
		global.shake /= 1.5
		slow_shake /= 1.1

		if global.shake >= 1000:
			slow_shake = 10

