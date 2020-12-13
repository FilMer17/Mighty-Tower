extends Node2D

const WIDTH = 150
const HEIGHT = 150

const TILES = {
	'grass': 0,
	'sand': 1,
	'stone': 2,
	'tree': 3,
	'water': 4
}

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

func _generate_world():
	for x in WIDTH:
		for y in HEIGHT:
			$TileMap.set_cellv(Vector2(x - WIDTH / 2.0, y - HEIGHT / 2.0), _get_tile_index(open_simplex_noise.get_noise_2d(float(x), float(y))))

func _get_tile_index(noise_sample):
	if noise_sample < -0.1:
		return TILES.water
	if noise_sample < 0.0:
		return TILES.sand
	else:
		return TILES.grass
