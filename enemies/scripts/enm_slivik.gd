extends enemy

func _ready() -> void:
	score_get = 100
	energy_get = 4
	health = 50
	coin_get = 1
	damage = 30

func _physics_process(delta: float) -> void:
	movement += (global.player_pos - position) * 0.1
	if position.distance_squared_to(global.player_pos) < 7000:
		movement -= (global.player_pos - position) 
		

func _on_hitbox_area_entered(area: Area2D) -> void:
	global.player_damage = damage
	hit()

	

