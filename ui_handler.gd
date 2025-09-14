extends Node

var inv_selection = "Log"
var mode = "building"
var coins = 0

func _ready() -> void:
	time()
func time() -> void:
	await get_tree().create_timer(60).timeout
	coins += 1
	time()
