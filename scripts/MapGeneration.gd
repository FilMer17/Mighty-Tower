extends TileMap

const WIDTH = 150
const HEIGHT = 150

const TILES = {
	'grass': 0,
	'sand': 1,
	'stone': 2,
	'tree': 3,
	'water': 4,
	'fog' : 5
}

var fog_parts = [
	Vector2(0, 0), Vector2(1 * WIDTH / 3.0, 0), Vector2(2 * WIDTH / 3.0, 0),
	Vector2(0, 1 * HEIGHT / 3.0), Vector2(2 * WIDTH / 3.0, 1 * HEIGHT / 3.0),
	Vector2(0, 2 * HEIGHT / 3.0), Vector2(1 * WIDTH / 3.0, 2 * HEIGHT / 3.0), Vector2(2 * WIDTH / 3.0, 2 * HEIGHT / 3.0)
#		Vector2(1 * WIDTH / 3.0, 1 * HEIGHT / 3.0), 
	]

var open_simplex_noise

func _ready():
#	randomize();
	open_simplex_noise = OpenSimplexNoise.new()
	open_simplex_noise.seed = randi()
	
	# change values for new types of map
	open_simplex_noise.octaves = 4
	open_simplex_noise.period = 15
	open_simplex_noise.lacunarity = 1.5
	open_simplex_noise.persistence = 0.75
	
	_generate_world()
	_generate_fog()

func _generate_world():
	for x in WIDTH:
		for y in HEIGHT:
			set_cellv(Vector2(x - WIDTH / 2.0, y - HEIGHT / 2.0), _get_tile_index(open_simplex_noise.get_noise_2d(float(x), float(y))))

func _get_tile_index(noise_sample):
	var rand = randi() % 10
	
	if noise_sample < -0.1:
		return TILES.water
	if noise_sample < 0.0:
		return TILES.sand
	if noise_sample > 0.3:
		return TILES.stone
	else:
		if rand == 1:
			return TILES.tree
		return TILES.grass

func _generate_fog():
	for x in WIDTH / 3.0:
		for y in HEIGHT / 3.0:
			for fog in fog_parts:
				set_cellv(Vector2(x - WIDTH / 2.0, y - HEIGHT / 2.0) + fog, TILES.fog)

func _unlock_fog(unlock):
	for x in WIDTH / 3.0:
		for y in HEIGHT / 3.0:
			set_cellv(Vector2(x - WIDTH / 2.0, y - HEIGHT / 2.0) + unlock, _get_tile_index(open_simplex_noise.get_noise_2d(float(x + unlock.x), float(y + unlock.y))))

func _physics_process(_delta):
	if Input.is_action_just_pressed("ui_home"):
		_unlock_fog(fog_parts[int(rand_range(0, 8))])
