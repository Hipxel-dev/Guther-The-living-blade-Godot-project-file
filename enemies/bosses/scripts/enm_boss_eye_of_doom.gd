extends enemy

var bullet = preload("res://enemies/projectiles/enemy_projectile.tscn")
var fire_rate = 3

func _ready() -> void:
	score_get = 30000
	energy_get = 4
	health = 500
	coin_get = 16
	
	
func _physics_process(delta: float) -> void:
	movement /= 1.1
	
	fire_rate -= delta
	if fire_rate < 0:
		for i in range(6):
			var bullet_inst = bullet.instance()
			bullet_inst.position = $shoot_pos.global_position
			bullet_inst.movement += (global.player_pos - position).normalized() * 900
			bullet_inst.movement += Vector2(rand_range(-100,100), rand_range(-100,100))
			get_parent().add_child(bullet_inst)
		fire_rate = 3
	
	
	movement += (global.player_pos - position) * rand_range(0, 3)
	movement -= (global.player_pos - position) * rand_range(0, 3)


func _on_hitbox_area_entered(area: Area2D) -> void:
	hit()
	
