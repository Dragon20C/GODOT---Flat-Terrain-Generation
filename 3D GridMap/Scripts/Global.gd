extends Node

var RNG
var player

func _ready():
	randomize()
	RNG = randi()
