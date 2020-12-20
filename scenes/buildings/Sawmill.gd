extends StaticBody2D

var cost :int = 50
var wood_produce = 1

var timer

func _init():
	timer = Timer.new()
	add_child(timer)
	timer.autostart = true
	timer.wait_time = 3.0
	timer.connect("timeout", self, "_on_make_wood")

func _physics_process(_delta):
	pass

func _on_make_wood():
	MapStats.wood += wood_produce
	MapStats.money += 1
	var parent = get_parent().get_parent().get_parent()
	parent.get_node("CanvasLayer/Money").text = "Money: " + str(MapStats.money)
	parent.get_node("CanvasLayer/Wood").text = "Wood: " + str(MapStats.wood)
