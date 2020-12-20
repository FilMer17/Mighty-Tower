extends Node2D

var timer

func _ready():
	$CanvasLayer/Money.text = "Money: " + str(MapStats.money)
	$CanvasLayer/Wood.text = "Wood: " + str(MapStats.wood)

func _init():
	timer = Timer.new()
	add_child(timer)
	timer.autostart = true
	timer.wait_time = 1.0
	timer.connect("timeout", self, "_on_make_money")

func _on_make_money():
	MapStats.money += 1
	$CanvasLayer/Money.text = "Money: " + str(MapStats.money)
