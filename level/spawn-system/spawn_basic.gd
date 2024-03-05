extends Sprite

var enemies = [preload("res://enemies/enm_stavik.tscn"), preload("res://enemies/enm_slivik.tscn")]
var bosses = [preload("res://enemies/bosses/enm_boss_eye_of_doom.tscn")]
var spwn_interval = rand_range(1, 5)
var boss_interval = rand_range(30, 90)


func _physics_process(delta: float) -> void:
	if global.player_alive:
		spwn_interval -= delta
		spwn_interval -= delta
		spwn_interval -= delta
		spwn_interval -= delta
		spwn_interval -= delta
		spwn_interval -= delta
		spwn_interval -= delta
		spwn_interval -= delta
		boss_interval -= delta
		if global.current_wave_effect == "swarmer":
			spwn_interval -= delta
			boss_interval -= delta
	
	if boss_interval < 0:
		if rand_range(0, 1) > 0.5:
			var boss_inst = bosses[floor(rand_range(0, bosses.size()))].instance()
			boss_inst.position = position
			get_tree().get_root().add_child(boss_inst)
			boss_interval = rand_range(30, 60)
	

	if spwn_interval < 0:
		var enemy_inst = enemies[floor(rand_range(0, enemies.size()))].instance()
		enemy_inst.position = position
		get_tree().get_root().add_child(enemy_inst)
		spwn_interval = rand_range(1, 10)
