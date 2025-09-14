extends CharacterBody3D

var moves: Array = []
var current: Vector2 = Vector2.ZERO
var deltas: float = 0.00
var last_cycle_velocity = Vector3.ZERO
var final_position
var object_count := 0
var meshes: Dictionary = {"Fence 1": preload("res://images/vox/fence_end.vox"),"Fence 2": preload("res://images/vox/fence_edge.vox"),"Fence 3": preload("res://images/vox/fence_straight.vox"),"Fence 4": preload("res://images/vox/fence_t.vox"),"Fence 5": preload("res://images/vox/fence_x.vox"),"Log": preload("res://images/vox/log.vox"),"Flower": preload("res://images/vox/flower.vox"),"Grass": preload("res://images/vox/grass.vox"),"Bush": preload("res://images/vox/bush.vox")}
var current_mesh = "Log"
func _physics_process(delta: float) -> void:
	move()

	if current_mesh != UiHandler.inv_selection:
		current_mesh = UiHandler.inv_selection
		$next/ind/MeshInstance3D.mesh = meshes[UiHandler.inv_selection]
	if UiHandler.mode == "building":
		$next/ind/MeshInstance3D.visible = true
		$next/delete.visible = false
	elif UiHandler.mode == "deleting":
		$next/ind/MeshInstance3D.visible = false
		$next/delete.visible = true
	else:
		$next/ind/MeshInstance3D.visible = false
		$next/delete.visible = false
	if Input.is_action_just_pressed("ui_rotate"):
		$next/ind.rotate(Vector3(0,1,0), deg_to_rad(90))
	
	if Input.is_action_just_pressed("ui_left"):
		moves.append(Vector2(-1,0))
	if Input.is_action_just_pressed("ui_right"):
		moves.append(Vector2(1,0))
	if Input.is_action_just_pressed("ui_up"):
		moves.append(Vector2(0, -1))
	if Input.is_action_just_pressed("ui_down"):
		moves.append(Vector2(0, 1))
	if Input.is_action_just_pressed("ui_place") and len(moves) == 0 and current == Vector2.ZERO:
		if UiHandler.mode == "building":
			await get_tree().physics_frame
			if len($next.get_overlapping_bodies()) == 0:
				var pos = (((position - Vector3(0.25, 1.125, 0.25)) * 2 + Vector3(1,0,0).rotated(Vector3(0,1,0), $next.rotation.y))) + Vector3(0,2,0)
				pos = (Vector3i(roundi(pos.x), roundi(pos.y), roundi(pos.z)))
				print(pos)
				self.get_parent().place(pos)
				await get_tree().physics_frame
				$next.rotate(Vector3(0,1,0), deg_to_rad(360))
		if UiHandler.mode == "deleting":
			await get_tree().physics_frame
			if len($next.get_overlapping_bodies()) != 0:
				var pos = (((position - Vector3(0.25, 1.125, 0.25)) * 2 + Vector3(1,0,0).rotated(Vector3(0,1,0), $next.rotation.y))) + Vector3(0,2,0)
				pos = (Vector3i(roundi(pos.x), roundi(pos.y), roundi(pos.z)))
				print(pos)
				self.get_parent().clear(pos)
				await get_tree().physics_frame
				$next.rotate(Vector3(0,1,0), deg_to_rad(360))
func move():
	if len(moves) != 0:
		if current == Vector2.ZERO:
			current = moves[0]
			var needed_angle = deg_to_rad(current.x * 90 - 90 if current.x != 0 else current.y *90)
			if $next.rotation.y != needed_angle:
				$next.rotation.y = 0
				$next.rotate(Vector3(0,1,0), deg_to_rad(current.x * 90 - 90 if current.x != 0 else current.y *-90))
			await get_tree().physics_frame
			var ret = false if len($next.get_overlapping_bodies()) == 0 else true 
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
