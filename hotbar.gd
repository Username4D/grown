extends Control

var moves = []
var iterations = 0
var current = 0
var range = 0
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inv_left") or Input.is_action_just_pressed("inv_right"):
		if not abs(range + Input.get_axis( "inv_right","inv_left")) > 4:
			moves.append(Input.get_axis( "inv_right","inv_left"))
			range += Input.get_axis( "inv_right","inv_left")
	if Input.is_action_just_pressed("1"):
		if UiHandler.mode == "building":
			UiHandler.mode = "watching"
		else:
			UiHandler.mode = "building"
	if Input.is_action_just_pressed("2"):
		if UiHandler.mode == "deleting":
			UiHandler.mode = "watching"
		else:
			UiHandler.mode = "deleting"
	if iterations == 0 and len(moves) != 0:
		current = moves[0]
		moves.remove_at(0)
	
	if iterations < 16:
		iterations += 1
		for i in self.get_children():
			i.position.x += 6 * current
			i._refresh()
	else:
		iterations = 0
		current = 0
