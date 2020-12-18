extends TileMap

export (Color, RGBA) var wrong
export (Color, RGBA) var right

onready var parent = self.get_parent()
#onready var choose_building = preload

# add buildings preloads here

var current_color = right
var tile
var mouse_pos
var is_right
var is_enable_build

func _ready():
	$Sprite.visible = false

func _physics_process(_delta):
	if is_enable_build:
		mouse_pos = get_global_mouse_position()
		tile = parent.world_to_map(mouse_pos)
		print(tile)
		position = map_to_world(tile)
		
		if parent.get_cellv(tile) == 0:
			current_color = right
		else:
			current_color = wrong
		
		$Sprite.material.set_shader_param('current_color', current_color)

func _input(event):
	if event.is_action_pressed("map_build"):
		if is_enable_build:
			is_enable_build = false
			$Sprite.visible = false
		else: 
			is_enable_build = true
			$Sprite.visible = true
#	if is_enable_build:
#		if event is InputEventMouseButton:
#			if event.button_index == BUTTON_LEFT:
#				if event.pressed:
#					MapStats.money += 1
#					print(MapStats.money)

