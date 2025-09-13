extends CharacterBody3D

var moves: Array = []
var current: Vector2 = Vector2.ZERO
var deltas: float = 0.00
var last_cycle_velocity = Vector3.ZERO
var final_position
var object_count := 0
func _physics_process(delta: float) -> void:
	move()


	if Input.is_action_just_pressed("ui_left"):
		moves.append(Vector2(-1,0))
	if Input.is_action_just_pressed("ui_right"):
		moves.append(Vector2(1,0))
	if Input.is_action_just_pressed("ui_up"):
		moves.append(Vector2(0, -1))
	if Input.is_action_just_pressed("ui_down"):
		moves.append(Vector2(0, 1))

func move():
	if len(moves) != 0:
		if current == Vector2.ZERO:
			current = moves[0]
			var needed_angle = deg_to_rad(current.x * 90 - 90 if current.x != 0 else current.y *90)
			if $next.rotation.y != needed_angle:
				$next.rotation.y = 0
				$next.rotate(Vector3(0,1,0), deg_to_rad(current.x * 90 - 90 if current.x != 0 else current.y *-90))
			$next.rotate(Vector3(0,1,0), deg_to_rad(0.5))
			await get_tree().physics_frame
			print($next.get_overlapping_bodies())
			var ret = false if len($next.get_overlapping_bodies()) == 0 else true
			print(object_count)
			if not ret:
				deltas = 0
				last_cycle_velocity = Vector3.ZERO
				final_position = position + Vector3(current.x / 2, 0, current.y / 2)
				
			else:
				moves.remove_at(0)
				current = Vector2.ZERO
				velocity = Vector3.ZERO
				return
		deltas += 1
		var new_velo = Vector3(GlobalFunctions.easeInOutQuint((current.x / 10.0 * (deltas + 1))) * current.x, 0 ,GlobalFunctions.easeInOutQuint((current.y) / 10.0 * (deltas + 1)) * current.y)

		
		if not deltas >= 9:
			velocity = new_velo - last_cycle_velocity 

		else:
			moves.remove_at(0)
			current = Vector2.ZERO

			self.position = final_position

			velocity = Vector3.ZERO
		last_cycle_velocity = new_velo
		move_and_collide(velocity / 2)
