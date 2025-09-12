extends CharacterBody3D

var moves: Array = []
var current: Vector2 = Vector2.ZERO
var deltas: float = 0.00
func _physics_process(delta: float) -> void:
	if len(moves) != 0:
		if current == Vector2.ZERO:
			current = moves[0]
			deltas = 0
		deltas += 1
		
		print(velocity)
		if not deltas >= 10:
			velocity = Vector3(current.x, 0, current.y) / 10 * 1
		else:
			moves.remove_at(0)
			current = Vector2.ZERO
		move_and_collide(velocity)
	
	if Input.is_action_just_pressed("ui_left"):
		moves.append(Vector2(-1,0))
	if Input.is_action_just_pressed("ui_right"):
		moves.append(Vector2(1,0))
	if Input.is_action_just_pressed("ui_up"):
		moves.append(Vector2(0, -1))
	if Input.is_action_just_pressed("ui_down"):
		moves.append(Vector2(0, 1))
