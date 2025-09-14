extends Node3D

var items_to_index = ["Fence 2", "Bush", "", "Fence 1", "Fence 3", "Fence 4", "Fence 5", "Flower", "Grass", "Leaf", "Log"]

func place(pos: Vector3) -> void:
	$GridMap.set_cell_item(pos, items_to_index.find(UiHandler.inv_selection))
