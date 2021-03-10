extends Spatial

var noise = OpenSimplexNoise.new()
const size = 20
var tile_selection
onready var gridmap = $GridMap
onready var GridItems = $GridItems
onready var player = Global.player
onready var world = get_node("/root/World/")

func _ready():
	#gridmap.translation = Vector3(world.chunk_pos.x * size, 0,world.chunk_pos.y * size)
	#GridItems.translation = Vector3(world.chunk_pos.x * size, 0,world.chunk_pos.y * size)
	#gridmap.translation = Vector3(player.translation.x, 0,player.translation.z) - Vector3(size/2,0,size/2)
	#GridItems.translation = Vector3(player.translation.x, 0,player.translation.z) - Vector3(size/2,0,size/2)
	var RNG = Global.RNG
	noise.seed = RNG
	
func chunk_position_set(set_pos):
	gridmap.translation = set_pos
	GridItems.translation = set_pos
	terrain_generation(set_pos)
	generate_nature(set_pos)
	
	
func terrain_generation(position):
	var pos = Vector3(position.x, 0,position.z)
	#var pos = Vector3(player.translation.x, 0,player.translation.z)
	for x in range(size):
		for y in range(size):
			var height = noise.get_noise_2d((pos.x + x) /1.5, (pos.z + y)/1.5) * 2
			if height > -0.25 and height < 0:
				tile_selection = 2 #Water
			elif height < -0.25:
				tile_selection = 4 #Dark Water
			elif height > 0 and height < 0.1:
				tile_selection = 1 # Sand
			elif height < 0.8 and height > 0.4:
				tile_selection = 5 # Dark Grass
			elif height > 0.8:
				tile_selection = 3
			else:
				tile_selection = 0 # Grass
			gridmap.set_cell_item(x,0,y,tile_selection)
			
func generate_nature(position):
	var pos = Vector3(position.x, 0,position.z)
	#var pos = Vector3(player.translation.x, 0,player.translation.z)
	for x in range(size):
		for y in range(size):
			var chance = randi() % 100 + 1
			var height = noise.get_noise_2d((pos.x + x) /1.5, (pos.z + y)/1.5) * 2
			if height > -0.25 and height < 0:
				if chance < 0:
					tile_selection = 0 #Water
			elif height < -0.25:
				if chance < 0:
					tile_selection = 0 #Dark Water

			if height < 0.8 and height > 0.4:
				if chance <= 12 and chance > 5:
					tile_selection = 0 # Dark Grass
					GridItems.set_cell_item(x,0,y,tile_selection)
				elif chance <= 3:
					tile_selection = 2 # Rocks
					GridItems.set_cell_item(x,0,y,tile_selection)
			elif height > 0 and height < 0.1:
				if chance < 10:
					tile_selection = 3 # Cactus
					GridItems.set_cell_item(x,0,y,tile_selection)
			elif height > 0.8:
				if chance < 10:
					tile_selection = 1 # snow
					GridItems.set_cell_item(x,0,y,tile_selection)
			elif height < 0.8 and height > 0:
				if chance < 6 and chance > 3:
					tile_selection = 0 # Grass
					GridItems.set_cell_item(x,0,y,tile_selection)
				elif chance <= 3:
					tile_selection = 2 # Rocks
					GridItems.set_cell_item(x,0,y,tile_selection)
			
