extends Camera2D

# camera zoom settings
export (bool) var wheel_z = true
export (int) var limit_z = 100

var cam_zoom :Vector2 = get_zoom()
var speed_z :Vector2 = Vector2(0.05, 0.05)

# camera movement setings
export (bool) var drag_m = true
export (bool) var edge_m = true
export (bool) var key_m = true
export (int) var margin_m = 50
export (int) var speed_m = 10



func _ready():
	smoothing_enabled = true
	smoothing_speed = speed_m
	
	drag_margin_h_enabled = true
	drag_margin_v_enabled = true
	drag_margin_left = 0.8
	drag_margin_top = 0.7
	drag_margin_right = 0.8
	drag_margin_bottom = 0.7

func _input(event):
	if key_m:
		if event is InputEventKey:
			if event.scancode == KEY_LEFT:
				position = position - Vector2(speed_m, 0)
			if event.scancode == KEY_UP:
				position = position - Vector2(0, speed_m)
			if event.scancode == KEY_RIGHT:
				position = position + Vector2(speed_m, 0)
			if event.scancode == KEY_DOWN:
				position = position + Vector2(0, speed_m)
	
	if edge_m:
		if event is InputEventKey:
			if event.scancode == KEY_M:
				smoothing_speed = 5
				position = get_global_mouse_position()
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_WHEEL_UP:
			if zoom > Vector2(0.3, 0.3):
				zoom = zoom - speed_z
		elif event.button_index == BUTTON_WHEEL_DOWN:
			if zoom < Vector2(3, 3):
				zoom = zoom + speed_z
		elif event.button_index == BUTTON_MIDDLE:
			zoom = Vector2(1, 1)

#	if drag_m:


#var _cz = 0.75
#var cam_zoom = Vector2(_cz, _cz)
#
#var _zn = 0.05
#var zoom_num = Vector2(_zn, _zn)
#
#func _ready():
#	zoom = cam_zoom
#
#func _input(event):
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_WHEEL_UP:
#			if zoom > Vector2(0.3, 0.3):
#				zoom = zoom - zoom_num
#		elif event.button_index == BUTTON_WHEEL_DOWN:
#			if zoom < Vector2(3, 3):
#				zoom = zoom + zoom_num
