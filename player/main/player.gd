extends KinematicBody2D

var movement = Vector2.ZERO

onready var anim = $p_anim

var rot_vel = 0

var hitbox = preload("res://player/attacks/hitbox.tscn")
var is_attacking = false

var charge_cancel_delay = 0.07
var attack_rate = 1
var last_health = global.health
var i_frame = 0

var charge_1_energy = 50

func _ready() -> void:
#	global.reset()
	$shadow.set_as_toplevel(true)
	$sprite/charge_1.set_as_toplevel(true)

func animate(delta):
	rot_vel /= 2
	$sprite.rotation_degrees += rot_vel
	rot_vel += (0 - $sprite.rotation_degrees)
	
	if $sprite/slash_1.frame == 10:
		$sprite/slash_1.hide()
		
	$shadow.rotation = $sprite.global_rotation 
	$shadow.position = (global_position + Vector2(-0, 8)) + Vector2(cos($sprite.rotation), sin($sprite.rotation) * 32)
	

func charge_1(delta):
	charge_1_energy -= delta
	if charge_1_energy > 0:
		$sprite/charge_1.position = position
		$sprite/charge_1.rotation_degrees = rotation_degrees + 40
		$sprite/charge_1.show()
		$sprite/charge_1.playing = true
		$sprite/effect/particles.restart()
		$sprite.offset.x = 32 + sin(OS.get_ticks_msec() * delta * 15) * 70
		global.shake += 1
		movement /= 7
	else:
		global.super -= 1
		anim.play("charge_1")
		is_attacking = true
		if global.super > 0:
			global.player_damage = 150
		else:
			global.player_damage = 50
			
		$charge_1_sfx.play()
		rot_vel = 100
		rotation_degrees = 90
		$sprite/effect/particles.emitting = true
		$sprite/charge_1.hide()
		movement = (get_global_mouse_position() - position).normalized() * 3600
		attack_rate = -0.4

func attack_2():
	$sprite/slash_1.show()
	anim.play("attack_2")
	$attack_2_sfx.play()
	is_attacking = true
	$sprite/slash_1.frame = 0
	attack_rate = -0.3
	global.player_damage = 10
	movement = (get_global_mouse_position() - position).normalized() * 1600
	movement *= 1.1
	
	rot_vel += 10
	var hit_inst = hitbox.instance()
	hit_inst.position = position
	get_parent().add_child(hit_inst)
	
	
func attack_1():
	$sprite/slash_1.show()
	anim.play("attack_1")
	is_attacking = true
	$sprite/slash_1.frame = 0
	$attack_1_sfx.volume_db = 25
	$attack_1_sfx.play()
	global.player_damage = 20
	movement *= 0.2
	movement = (get_global_mouse_position() - position).normalized() * 1600
	
	var hit_inst = hitbox.instance()
	hit_inst.position = position
	get_parent().add_child(hit_inst)
	attack_rate = -0.2


func attack_system(delta):
	$sprite.offset += (Vector2(32, 0) - $sprite.offset) * 0.25
	attack_rate += delta
	if Input.is_action_just_pressed("CLICK") and attack_rate >= 0:
		attack_1()
	if Input.is_action_just_pressed("ALTCLICK") and attack_rate >= 0:
		attack_2() 

	charge_cancel_delay -= delta
	if Input.is_action_just_pressed("CLICK"):
		$sprite/charge_1.frame = 0
	if Input.is_action_pressed("CLICK") and attack_rate > 0.01:
		charge_1(delta)
		charge_cancel_delay = 0.19
	elif charge_cancel_delay < 0:
		charge_1_energy = 0.3
		$sprite/charge_1.hide()
		
	if attack_rate < 0 and $sprite/effect/particles.emitting:
		is_attacking = true
		
func _physics_process(delta: float) -> void:
	animate(delta)
	attack_system(delta)
	
	if Input.is_action_just_pressed("ui_down"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if is_attacking:
		$sprite/hitrect.monitorable = true
		$sprite/hurtrect.monitoring = false
	elif attack_rate > 0:
		$sprite/hitrect.monitorable = false
		$sprite/hurtrect.monitoring = true
	
	global.player_pos = global_position
	global.player_vel = movement
	
	if not anim.current_animation == "attack_2":
		movement += (get_global_mouse_position() - position) 
	movement /= 1.16
	
	if anim.current_animation != "attack_2":
		rotation = movement.angle()

	move_and_slide(movement)
	
	i_frame -= delta
	if i_frame > 0 and Engine.time_scale == 1:
		$sprite.modulate = Color8(255,255,255,sin(OS.get_ticks_msec() * delta * 3) * 255)
	else:
		$sprite.modulate = Color.white
		
	if last_health != global.health:
		$player_damaged.volume_db = 10
		$player_damaged.play()
		anim.play("none")
		global.shake += 39
		Engine.time_scale = 0.008
		last_health = global.health
		i_frame = 5
		
	if global.health <= 0:
		queue_free()
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://level/mainmenu/main_menu.tscn")
	$music.pitch_scale = 0.5
func set_attack_bool_2_false():
	is_attacking = false
func set_attack_boos_2_true():
	is_attacking = true


func _on_hurtrect_area_entered(area: Area2D) -> void:
	pass
#	var check_if_theres_enemy = get_tree().get_nodes_in_group("enemy")
#	if check_if_theres_enemy != []:
#		yield(get_tree().create_timer(0.03), "timeout")
#		if area.is_in_group("enemy"):
#			if not is_attacking and i_frame < 0:
#				global.health -= global.enemy_damage
#
#		if area.is_in_group("enm_attack"):
#			if i_frame < 0:
#				global.health -= global.enemy_damage
