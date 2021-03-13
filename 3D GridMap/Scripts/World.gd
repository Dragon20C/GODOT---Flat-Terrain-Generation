extends Spatial

var chunk = preload("res://Scripts/MapGen.gd")
var chunk_scene = preload("res://Scenes/MapGen.tscn")
onready var player = get_node("/root/World/Player")
onready var chunk_local_cube = $Chunk_local
var chunk_x = 1
var chunk_z = 1
var chunk_pos = Vector2()
var previous_chunks = []
	
func _process(delta):
	chunk_local_cube.translation = Vector3(chunk_pos.x * chunk.size,0,chunk_pos.y * chunk.size)
	#print(chunk_pos)
	var chunk_x = floor(player.translation.x / chunk.size)
	var chunk_z = floor(player.translation.z / chunk.size)
	var new_chunk_pos = Vector2(chunk_x, chunk_z)
	
	if new_chunk_pos != chunk_pos:
		if !new_chunk_pos in previous_chunks:
			chunk_pos = new_chunk_pos
			var instance = chunk_scene.instance()
			add_child(instance)
			instance.chunk_position_set(Vector3(chunk_pos.x * chunk.size,0,chunk_pos.y * chunk.size))
			previous_chunks.append(chunk_pos)
			#print(previous_chunks)
