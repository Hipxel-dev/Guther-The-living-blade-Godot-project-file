extends Node2D

func _ready() -> void:
	position.y = 99999
	$press_any.hide()
	$sprite.hide()

func _input(event):
	if menuscene.current_menu_state == menuscene.menu_states.PRESS_START:
		if event is InputEventKey and event.pressed:
			menuscene.current_menu_state = menuscene.menu_states.MAIN
			$menu_sfx.play()

func _physics_process(delta: float) -> void:
	if menuscene.current_menu_state == menuscene.menu_states.PRESS_START:
		position /= 1.1
		if position.distance_squared_to(Vector2.ZERO) < 100:
			$press_any.show()
			$sprite.show()
		else:
			$press_any.hide()
			$sprite.hide()
			
	else:
		position = position.linear_interpolate(Vector2(0, -900), delta * 5)
