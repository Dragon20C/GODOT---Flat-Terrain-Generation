extends Spatial

var chunk = preload("res://Scripts/MapGen.gd")
var chunk_scene = preload("res://Scenes/MapGen.tscn")
onready var player = get_node("/root/World/Player")
onready var chunk_local_cube = $Chunk_local
var chunk_x = 1
var chunk_z = 1
var chunk_pos = Vector2()
var previous_chunks = []
var chunk_position
var chunk_dict = {"position1": Vector2(chunk_pos.x,chunk_pos.y + 3),
"position2": Vector2(chunk_pos.x,chunk_pos.y + 2),
"position3": Vector2(chunk_pos.x,chunk_pos.y + 1)}
func _ready():
	pass
	#for x in chunk_dict.size():
	#	var instance = chunk_scene.instance()
	#	add_child(instance)
	#	instance.chunk_position_set(Vector3(chunk_pos.x * chunk.size,0,x * chunk.size))
	#	previous_chunks.append(Vector2(chunk_pos.x,x))
	
func _process(delta):
	chunk_local_cube.translation = Vector3(chunk_pos.x * chunk.size,0,chunk_pos.y * chunk.size)
	#print(chunk_pos)
	var chunk_x = floor(player.translation.x / chunk.size)
	var chunk_z = floor(player.translation.z / chunk.size)
	var new_chunk_pos = Vector2(chunk_x, chunk_z)
	chunk_position = new_chunk_pos
	if new_chunk_pos != chunk_pos:
		if !new_chunk_pos in previous_chunks:
				chunk_pos = new_chunk_pos
				generate_chunk_amount()
	#	if !new_chunk_pos in previous_chunks:
	#		chunk_pos = new_chunk_pos
	#		var instance = chunk_scene.instance()
	#		add_child(instance)
	#		instance.chunk_position_set(Vector3(chunk_pos.x * chunk.size,0,chunk_pos.y * chunk.size))
	#		previous_chunks.append(chunk_pos)
			#print(previous_chunks)
			
func generate_chunk_amount():
	for x in range(3):
		for y in range(3):
			var chunk_x = floor(player.translation.x / chunk.size)
			var chunk_z = floor(player.translation.z / chunk.size)
			var new_x = x + chunk_x
			var new_y = y + chunk_z
			var new_chunk = Vector2(new_x,new_y)
			if !new_chunk in previous_chunks:
				var instance = chunk_scene.instance()
				add_child(instance)
				instance.chunk_position_set(Vector3(new_x * chunk.size,0,new_y * chunk.size))
				previous_chunks.append(Vector2(new_x,new_y))
				#print(previous_chunks)
