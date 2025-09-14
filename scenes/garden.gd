extends Node3D

var items_to_index = ["", "Bush", "Fence 2", "Fence 1", "Fence 3", "Fence 4", "Fence 5", "Flower", "Grass", "Leaf", "Log"]

func place(pos: Vector3i) -> void:
	$GridMap.set_cell_item(pos, items_to_index.find(UiHandler.inv_selection))

func clear(pos):
	$GridMap.set_cell_item(pos, -1)
