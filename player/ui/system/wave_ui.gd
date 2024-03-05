extends Node2D

enum states {wave_change_alert, wave_in_progress, wave_nearing_end}
var state = states.wave_change_alert

var alert_duration = 7

onready var wave_bar = $rect/wave_bar

func _physics_process(delta: float) -> void:
	alert_duration -= delta
	
	wave_bar.value = 60 - global.wave_duration
	
	if global.current_wave_effect != "none":
		$rect/wave_effect_text.text = str("effect: ", global.current_wave_effect)
	else:
		$rect/wave_effect_text.text = str("")
	$rect/wave_text.text = str("Wave: " ,global.wave)
	
	
	if alert_duration > 0:
		state = states.wave_change_alert
	else:
		state = states.wave_in_progress
		
	
