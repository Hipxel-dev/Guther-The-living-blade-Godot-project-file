extends Node2D

onready var buttons = [$origins, $back]

var last_index = 0
var index = 0

var mouse_rect = Vector2(32, 8)
var mouse_scan_area = []

var tex = preload("res://art/level_art/main_menu_art/menu_line.png")

func _draw() -> void:
	for i in range(buttons.size()):
		draw_texture(tex, buttons[index].position + Vector2(-0, -5))
		draw_line(buttons[index].position + Vector2(-132, 0), buttons[index].position + Vector2(600, 0), Color.red, 1.0)
	
func do_stuff_of_the_selected_button(delta): 
	for i in range(buttons.size()):
		buttons[index].get_node("text").rect_position.x = 34 + (abs(sin(OS.get_ticks_msec() * delta * 5) * (global.shake * 15)))
		buttons[index].modulate = Color8(255,0,0)
		
	if Input.is_action_just_pressed("ui_down"):
		if index < buttons.size() - 1:
			index += 1
		else:
			index = 0
		get_tree().get_root().warp_mouse(buttons[index].global_position + Vector2(-16, 0))
		
	if Input.is_action_just_pressed("ui_up"):
		if index > 0:
			index -= 1
		else:
			index = buttons.size() - 1
		get_tree().get_root().warp_mouse(buttons[index].global_position + Vector2(-16, 0))
		
func _physics_process(delta: float) -> void:
	if menuscene.current_menu_state == menuscene.menu_states.SUB_CHAPTER_SELECT:
		update()
		position = position.linear_interpolate(Vector2(32, 32), delta * 15)
		do_stuff_of_the_selected_button(delta)
		
		for i in range(buttons.size()):
			buttons[i].position.y += (i * 20 - buttons[i].position.y) * 0.6
			buttons[i].position.x += (0 - buttons[i].position.x) * 0.6
			buttons[1].position.y += 5
			buttons[i].get_node("text").rect_position.x += rand_range(-global.shake, global.shake) * 5
			buttons[i].get_node("text").rect_position.x /= 2
			buttons[i].modulate = buttons[i].modulate.linear_interpolate(Color.white, delta * 3)
#			buttons[i].get_node("text").rect_position.y += (-8 - buttons[i].get_node("text").rect_position.y) * 0.9
			
		for i in range(buttons.size()):
			if get_local_mouse_position().y > (buttons[i].position.y - 8) and get_local_mouse_position().y < (buttons[i].position.y + 8):
				if get_local_mouse_position().x > (buttons[i].position.x) and get_local_mouse_position().x < (buttons[i].position.x + 402):
					index = i
					
		if Input.is_action_just_pressed("CLICK") or Input.is_action_just_released("ui_accept"):
			global.shake = 1500
			$menu_cycle_sfx.pitch_scale = 0.7
			$menu_cycle_sfx.volume_db = 10
			$menu_cycle_sfx.play()
			if position.distance_squared_to(Vector2(32, 32)) < 300:
#				if index == 0:
#					menuscene.current_menu_state = menuscene.menu_states.MAIN
				if index == 1:
					menuscene.current_menu_state = menuscene.menu_states.SUB_PLAY_LEVEL_SELECT

			
		if last_index != index:
			$menu_cycle_sfx.pitch_scale = 1
			$menu_cycle_sfx.volume_db = 1
			$menu_cycle_sfx.play()
			global.shake += 15
			last_index = index
	else:
		position = position.linear_interpolate(Vector2(999,88), delta * 15)
