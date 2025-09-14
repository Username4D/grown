extends Control

var moves = []
var iterations = 0
var current = 0

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inv_left") or Input.is_action_just_pressed("inv_right"):
		moves.append(Input.get_axis( "inv_right","inv_left"))
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
