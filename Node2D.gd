extends Node2D


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("CLICK"):
		for i in range(5):
			fx.spwn_gib(get_local_mouse_position())
		fx.spwn_blood_splash_big(get_global_mouse_position())
		fx.spwn_blood_splash_massive(get_global_mouse_position())
		fx.spwn_blood_splash_directional(get_global_mouse_position())
		fx.spwn_splashpool(get_global_mouse_position())
		for o in rand_range(1, 15):
			fx.spwn_slash_spark(get_global_mouse_position(), 2, Color8(rand_range(0, 100), 0,0))
			fx.spwn_impact_single(get_global_mouse_position(), rand_range(0.2, 0.5), rand_range(-320,320), Color8(rand_range(0, 100), 0, 0))
#		for m in range(15):
#			fx.spwn_slash_spark(get_global_mouse_position())
#			fx.spwn_slash_spark(get_global_mouse_position(), 1, Color.red)
#			fx.spwn_blood_splash(get_global_mouse_position())
#			fx.spwn_blood_splash(get_global_mouse_position(), Color8(rand_range(140, 200), 0, 0))
