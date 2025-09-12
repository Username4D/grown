extends CharacterBody3D

var moves: Array = []
var current: Vector2 = Vector2.ZERO
var deltas: float = 0.00
var last_cycle_velocity
var final_position
func _physics_process(delta: float) -> void:
	if len(moves) != 0:
		if current == Vector2.ZERO:
			current = moves[0]
			deltas = 0
			last_cycle_velocity = Vector3.ZERO
			final_position = position + Vector3(current.x / 2, 0, current.y / 2)
			print(final_position)
		deltas += 1
		var new_velo = Vector3(GlobalFunctions.easeInOutQuint((current.x / 10.0 * (deltas + 1))) * current.x, 0 ,GlobalFunctions.easeInOutQuint((current.y) / 10.0 * (deltas + 1)) * current.y)

		
		if not deltas >= 9:
			velocity = new_velo - last_cycle_velocity 
			print("l")
		else:
			moves.remove_at(0)
			current = Vector2.ZERO
			print(self.position)
			self.position = final_position
			print(self.position)
			velocity = Vector3.ZERO
		last_cycle_velocity = new_velo
		move_and_collide(velocity / 2)
	
	if Input.is_action_just_pressed("ui_left"):
		moves.append(Vector2(-1,0))
	if Input.is_action_just_pressed("ui_right"):
		moves.append(Vector2(1,0))
	if Input.is_action_just_pressed("ui_up"):
		moves.append(Vector2(0, -1))
	if Input.is_action_just_pressed("ui_down"):
		moves.append(Vector2(0, 1))
