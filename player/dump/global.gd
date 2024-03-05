extends Node

var player_pos = Vector2.ZERO
var player_vel = Vector2.ZERO


var health = 150
var max_health = 150
var last_health = health

var coin = 0
var energy = 0
var score = 0
var hi_score = 0

var camera_pos = Vector2.ZERO

var shake = 0

var super = 0

var attack_amp_rand = 2

var enemy_damage = 10
var player_damage = 1

var wave_effects = ["none", "swarmer", "bullet hell"]
var current_wave_effect = wave_effects[0]
var wave_duration = 60
var wave = 1

var player_alive = true

var kills = 0
var damage_dealt = 0

var for_combo_enemy_killed = false

var ui_score_box_pos = Vector2.ZERO

func reset():
	var enemies = get_tree().get_nodes_in_group("node_enemy")
	for enm in enemies:
		enm.queue_free()
	
	health = max_health
	energy = 0
	super = 0
	score = 0
	coin = 0
	wave_duration = 0
	player_alive = true
	wave = 0
	current_wave_effect = wave_effects[0]


func _physics_process(delta: float) -> void:
	wave_duration -= delta
	if wave_duration < 0:
		wave += 1
		current_wave_effect = wave_effects[floor(rand_range(0, 2.99))]
		wave_duration = 60
	
	player_damage += abs(floor(rand_range(-attack_amp_rand, attack_amp_rand)))
	if global.health <= 0:
		
		var enemies = []
		enemies = get_tree().get_nodes_in_group("node_enemy")
		for enm in enemies:
			enm.health = -1
		
		player_alive = false
	

	
	# SORRY!. THE CALCULATION OF THE ENERGY SYSTEM IS HANDLED IN THE UI CODE!. LIKE WTF????
#	if super < 0:
#		super = 0
#	if energy >= 100:
#		energy = 0
#		super += 1
	

		
		
		
