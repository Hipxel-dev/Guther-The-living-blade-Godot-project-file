extends Node2D

onready var texts = [$text/score_text, $text/kills_text, $text/damage_dealth_text, $text/waves_survived_text]
onready var num = [$num_text/score_num, $num_text/kills_num, $num_text/damage_dealt_num, $num_text/waves_survived_num]

var index = 0
var countdown = 0.5
var show_delay = 1

var just_died = false

var helptexts = [
	"try being more aggresive when on low health",
	"when in doubt. spam attacks",
	"dont just get gud. get enjoyement",
	"try drinking water. might help you get your best run",
	"a Relaxed warrior stands longer than a panicked warrior"
]

var button_index = 0
onready var buttons = [$reset]

func _ready() -> void:
	hide()
	for i in range(4):
		texts[i].hide()
		num[i].hide()
	$youdiedlol/helptext.text = str(helptexts[floor(rand_range(0, helptexts.size()))])


func _physics_process(delta: float) -> void:
	if global.player_alive == false:
		global.shake *= 1.2
		if just_died == false:
			global.shake += 52
			$death_piano_thummmmm.play()
			just_died = true
		
		show_delay -= delta
		if show_delay < 0:
			$num_text/score_num.text = str(": ",global.score)
			$num_text/kills_num.text = str(": ",global.kills)
			$num_text/damage_dealt_num.text = str(": " ,global.damage_dealt)
			$num_text/waves_survived_num.text = str(": ",global.wave)
			
			countdown -= delta
			if countdown < 0 and index < 4:
				show()
				texts[index].show()
				num[index].show()
				index += 1
				$boom.play()
				global.shake += 25
				countdown = 0.5
		
			for i in range(buttons.size()):
				buttons[i].position.y += ( (i * 10) + 120 - buttons[i].position.y) * 0.3
				buttons[button_index].position.y += -3
				
			if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("CLICK"):
				if button_index == 0:
					global.reset()
					get_tree().reload_current_scene()
	else:
		index = 0
		countdown = 0.5
		show_delay = 1
		hide()
