extends Node

var impact_dir = preload("res://effects/impacts/impact_directional.tscn")
var impact_singl = preload("res://effects/impacts/impact_single.tscn")

var lineslash = preload("res://effects/impacts/lineslash.tscn")
var slash_spark = preload("res://effects/particlefx/slash_sparks.tscn")
var gib = preload("res://effects/gorefx/gib.tscn")
var bloodpool = preload("res://effects/gorefx/bloodpool.tscn")

var blood_splash = preload("res://effects/particlefx/blood_splash.tscn")

var sound = preload("res://sounds/sound_inst.tscn")

var score_visual = preload("res://player/ui/insts/score_visual.tscn")
var damage_number = preload("res://player/ui/insts/damage_number.tscn")

var splashpool = preload("res://effects/gorefx/splashpool.tscn")
var bloodsplashbig = preload("res://effects/gorefx/bloodsplashbig.tscn")
var bloodsplashmassive = preload("res://effects/gorefx/bloodsplashmassive.tscn")
var bloodsplashdirectional = preload("res://effects/gorefx/bloodsplashdirectional.tscn")

var bloodpoolquick = preload("res://effects/gorefx/bloodpoolquick.tscn")

func spwn_lineslash(pos):
	var lineslash_isnt = lineslash.instance()
	lineslash_isnt.position = pos
	lineslash_isnt.rotation_degrees = rand_range(-333,333)
	get_parent().add_child(lineslash_isnt)

func spwn_blood_pool_quick(pos):
	var bloodpoolquick_inst = bloodpoolquick.instance()
	bloodpoolquick_inst.position = pos
	get_parent().add_child(bloodpoolquick_inst)

func spwn_blood_splash_directional(pos):
	var bloodsplashdirectional_inst = bloodsplashdirectional.instance()
	bloodsplashdirectional_inst.position = pos
	get_parent().add_child(bloodsplashdirectional_inst)

func spwn_blood_splash_massive(pos):
	var bloodsplashmassive_inst = bloodsplashmassive.instance()
	bloodsplashmassive_inst.position = pos
	get_parent().add_child(bloodsplashmassive_inst)

func spwn_blood_splash_big(pos):
	var bloodsplashbig_inst = bloodsplashbig.instance()
	bloodsplashbig_inst.position = pos
	get_parent().add_child(bloodsplashbig_inst)

func blit_damage_number(number, pos):
	var damage_number_inst = damage_number.instance()
	damage_number_inst.position = pos
	damage_number_inst.number = number
	get_parent().add_child(damage_number_inst)

func blit_score_visual(score, pos):
	var score_visual_inst = score_visual.instance()
	score_visual_inst.position = pos
	score_visual_inst.score = score
	get_parent().add_child(score_visual_inst)

func sfx(stream, pos, vol = 0, pit = 1):
	var sound_inst = sound.instance()
	sound_inst.stream = stream
	sound_inst.position = pos
	sound_inst.volume_db = vol
	sound_inst.pitch_scale = pit
	get_parent().add_child(sound_inst)

func spwn_splashpool(pos):
	var bloodpool_inst = splashpool.instance()
	bloodpool_inst.position = pos
	get_parent().add_child(bloodpool_inst)

func spwn_bloodpool(pos):
	var bloodpool_inst = bloodpool.instance()
	bloodpool_inst.position = pos
	get_parent().add_child(bloodpool_inst)

func spwn_gib(pos, size = rand_range(0, 1.5)):
	var gib_inst = gib.instance()
#	gib_inst.modulate = 
	gib_inst.position = pos
	gib_inst.get_node("sprite").position.y = rand_range(-1, -36)
#	gib_inst.scale *= size
	get_parent().add_child(gib_inst)

func spwn_slash_spark(pos, size = 1, col = Color.white):
	var slash_spark_inst = slash_spark.instance()
	slash_spark_inst.position = pos
	slash_spark_inst.scale *= size
	slash_spark_inst.modulate = col
	get_parent().add_child(slash_spark_inst)

func spwn_impact_single(pos, size = rand_range(0.5, 1), rot = rand_range(-320,320), col = Color.white):
	var impact_single_inst = impact_singl.instance()
	impact_single_inst.position = pos
	impact_single_inst.scale *= size
	impact_single_inst.modulate = col
	impact_single_inst.rotation_degrees = rot
	get_parent().add_child(impact_single_inst)

func spwn_impact_dir(pos):
	var impact_dir_inst = impact_dir.instance()
	impact_dir_inst.position = pos
	impact_dir_inst.look_at(global.player_pos)
	impact_dir_inst.rotation += rand_range(-0.1,0.1)
	get_parent().add_child(impact_dir_inst)
	
func spwn_blood_splash(pos, col = Color.white):
	var blood_splash_inst = blood_splash.instance()
	blood_splash_inst.position = pos
	blood_splash_inst.modulate = col
	blood_splash_inst.look_at(global.player_pos)
	get_parent().add_child(blood_splash_inst)
