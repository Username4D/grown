extends Node3D

var items_to_index = ["", "Bush", "Fence 2", "Fence 1", "Fence 3", "Fence 4", "Fence 5", "Flower", "Grass", "Leaf", "Log"]

func place(pos: Vector3i, rot) -> void:
	$GridMap.set_cell_item(pos, items_to_index.find(UiHandler.inv_selection), $GridMap.get_orthogonal_index_from_basis(Basis(Vector3(0,1,0),rot)))
	
func clear(pos):
	$GridMap.set_cell_item(pos, -1)

func _process(delta: float) -> void:
	$CanvasLayer/Label.text = var_to_str(UiHandler.coins)
