extends KinematicBody2D
class_name enemy

var health = 1
var max_health = 0
var movement = Vector2.ZERO
var energy_get = 1
var coin_get = 1
var score_get = 1
var damage = 10

var hit_sound = [
	preload("res://sounds/impact_sounds/hit_1.wav"),
	preload("res://sounds/impact_sounds/hit_1.wav"),
	preload("res://sounds/impact_sounds/hit_2.wav")
	]
	
var death_sound = [
	preload("res://sounds/enemy_sounds/die_sounds/fleshy_death_5.wav"),
	preload("res://sounds/enemy_sounds/die_sounds/fleshy_death_2.wav"),
	preload("res://sounds/enemy_sounds/die_sounds/fleshy_death_3.wav"),
	preload("res://sounds/enemy_sounds/die_sounds/fleshy_death_4.wav"),
	preload("res://sounds/enemy_sounds/die_sounds/fleshy_death_1.wav")
	]


# effect vars
var shake = 0.1
var shaker = 0.03

var flash = 1
var flasher = 0.3

signal enemy_kill 

func _ready() -> void:
	add_to_group("node_enemy")
	yield(get_tree(). create_timer(0.1), "timeout")
	max_health = health

func _physics_process(delta: float) -> void:
	move_and_slide(movement, Vector2.UP, Vector2.AXIS_X)
	movement /= 1.1
	effects(delta)
	
	if health <= 0:
		die()

func die():
	global.for_combo_enemy_killed = true
	for i in range(coin_get + round(rand_range(-1, 0.6))):
		var coin_vel = (coin_get + 200) * 1.6
		event.spwn_coin(position, Vector2(rand_range(-coin_vel, coin_vel), rand_range(-coin_vel, coin_vel)))
	for i in range(max_health / 15):
		fx.spwn_gib(position + Vector2(rand_range(-4,4), rand_range(-8,8)), rand_range(0, 1))
	for o in rand_range(1, 5):
		fx.spwn_slash_spark(position, 2, Color8(rand_range(0, 100), 0,0))
		fx.spwn_impact_single(position, rand_range(0.2, 0.5), rand_range(-320,320), Color8(rand_range(0, 100), 0, 0))
	
	fx.spwn_bloodpool(position + Vector2(rand_range(-1,1), rand_range(-1,1))) 
	fx.spwn_splashpool(position)

	fx.spwn_blood_splash_directional(position)
	fx.spwn_blood_splash_big(position)
	fx.spwn_blood_splash_massive(position)
	fx.spwn_lineslash(position)
	
	fx.sfx(death_sound[floor(rand_range(0, death_sound.size()))], position, rand_range(0, 10), rand_range(1, 3.3))
	fx.sfx(hit_sound[floor(rand_range(0, hit_sound.size()))], position, rand_range(1, 2), rand_range(0.5, 1.5))
	
	global.kills += 1
	global.energy += energy_get * 3
	global.score += score_get
	fx.blit_score_visual(score_get, position)
	
	Engine.time_scale = 0.02
	queue_free()
	
func hit():
	# hitstop
	Engine.time_scale = 0.08
	
	shake = 1
	flash = 0.5
	movement -= (global.player_pos - position).normalized() * 300 * (global.player_damage / 20)
	movement += Vector2(rand_range(-100,100), rand_range(-100,100)).normalized() * 100 
	
	for i in rand_range(1, 3):
		fx.sfx(hit_sound[floor(rand_range(0, hit_sound.size()))], position, rand_range(-15, 2), rand_range(0.5, 1.5))
		fx.spwn_impact_single(position, rand_range(0.1, 1), rand_range(-320,320), Color.yellow)
	global.energy += energy_get
	
	for i in range(1):
		fx.spwn_bloodpool(position)
		fx.spwn_impact_single(position, rand_range(0, 0.5) + (global.player_damage / 100), rand_range(-320, 320), Color.red)
		fx.spwn_impact_single(position, rand_range(0, 0.5) + (global.player_damage / 100))
		fx.spwn_slash_spark(position)
		fx.spwn_slash_spark(position, 1, Color.red)
		fx.spwn_blood_splash(position)
		fx.spwn_blood_splash(position, Color8(rand_range(140, 200), 0, 0))

	$hit_sfx/bass.play()
	$hurt.play()
	
	global.score += score_get / 10
	global.shake += 3
	
	Engine.time_scale = 0.08
	take_damage()
	
func effects(delta):
	if flash > 0:
		flash -= delta
		flasher -= delta
		if flasher <= -0.03:
			flasher = 0.03
		if flasher <= 0:
			modulate = Color8(999999999999999999, 999999999999999999, 999999999999999999)
		else:
			modulate = Color8(255, 255, 255)
	else:
		modulate = Color.white
	if shake > 0:
		shake -= delta
		shaker -= delta
		if shaker <= -0.03:
			shaker = 0.03
		if shaker <= 0:
			$sprite.position.x = -3
		else:
			$sprite.position.x = 3
	else:
		$sprite.position.x = 0
	
func take_damage():
	health -= global.player_damage
	global.damage_dealt += global.player_damage
	fx.blit_damage_number(global.player_damage, position)
