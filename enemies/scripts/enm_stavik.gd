extends enemy

func _ready() -> void:
	score_get = 300
	energy_get = 7
	health = 100
	coin_get = 2
	damage = 30

func _physics_process(delta: float) -> void:
	movement += (global.player_pos - position) * 0.1
	movement *= rand_range(0.9, 1.1)

	if rand_range(1, 10) > 9:
		movement *= 3

	if movement.length() > 500:
		movement = movement.normalized() * 500

func _on_hitbox_area_entered(area: Area2D) -> void:
	global.enemy_damage = damage
	hit()

