extends Node

var coin = preload("res://player/dump/coin.tscn")

func spwn_coin(pos, vel = Vector2.ZERO):
	var coin_inst = coin.instance()
	coin_inst.position = pos
	coin_inst.movement = vel
	get_parent().add_child(coin_inst)
