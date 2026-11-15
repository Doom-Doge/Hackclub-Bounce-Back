extends CharacterBody2D

#direction true is right, false is left
var direction: int = 1
var Speed = 300


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity()
	velocity.x = direction * Speed
	if direction == 1:
		velocity.x = 200
	else:
		velocity.x = -200
	move_and_slide()
	


#func _process(delta):
#	for body in area.get_overlapping_bodies():
#		if body.is_in_group("Player"):
#			print("collisions!")""
