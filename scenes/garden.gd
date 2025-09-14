extends Node3D

var items_to_index = ["", "Bush", "Fence 2", "Fence 1", "Fence 3", "Fence 4", "Fence 5", "Flower", "Grass", "Leaf", "Log"]

func place(pos: Vector3i, rot) -> void:
	$GridMap.set_cell_item(pos, items_to_index.find(UiHandler.inv_selection), $GridMap.get_orthogonal_index_from_basis(Basis(Vector3(0,1,0),rot)))
func clear(pos):
	$GridMap.set_cell_item(pos, -1)
func _process(delta: float) -> void:
	$CanvasLayer/Label.text = "Coins: " + var_to_str(UiHandler.coins)
	if $CanvasLayer/Label.modulate.g != 1:
		$CanvasLayer/Label.modulate.g += 0.01
		$CanvasLayer/Label.modulate.b += 0.01
func broke() -> void:
	$CanvasLayer/Label.modulate.g = 0.5
	$CanvasLayer/Label.modulate.b = 0.5
func save():
	var Tiles = []
	var Positions = $GridMap.get_used_cells()
	for i in Positions:
		Tiles.append({"pos": i, "item": $GridMap.get_cell_item(i), "orientation": $GridMap.get_cell_item_orientation(i)})
	var gridmap = FileAccess.open("user://gridmap.txt", FileAccess.WRITE)
	gridmap.store_var(Tiles)
	var Coins = FileAccess.open("user://coins.txt", FileAccess.WRITE)
	Coins.store_64(UiHandler.coins)
	
func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		await save()
		get_tree().quit() # default behavior
func _ready() -> void:
	var gridmap = FileAccess.open("user://gridmap.txt", FileAccess.READ)
	if gridmap != null:
		var Tiles = gridmap.get_var()
		for i in Tiles:
			$GridMap.set_cell_item(i["pos"], i["item"], i["orientation"])
	var Coins = FileAccess.open("user://coins.txt", FileAccess.READ)
	if Coins:
		UiHandler.coins = Coins.get_64()
