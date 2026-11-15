extends CharacterBody2D

const speed = 300
const Jump_Velocity = -500
var health = 100

var innpc = false
var Iframe = 0

#func wait doesnt work (idk why)
func wait(s):
	await get_tree().create_timer(s).timeout

#Prevd is a failed var
func anims(direction):
	var prevd = direction
	#if direction == -1 and velocity.y > 0:
	#	$Sprite2D/AnimatedSprite2D.play("jump_left")
	#elif direction == 1 and velocity.y > 0:
	#	$Sprite2D/AnimatedSprite2D.play("jump_right")
	if direction == 1:
		$Sprite2D/AnimatedSprite2D.play("walk_right")
	elif direction == -1:
		$Sprite2D/AnimatedSprite2D.play("walk_left")
	elif velocity.y >= 1:
		$Sprite2D/AnimatedSprite2D.play("fall")
	else:
		$Sprite2D/AnimatedSprite2D.play("idle")
		#$Sprite2D/AnimatedSprite2D.play("idle")


func _physics_process(delta: float) -> void:
	
	#Text label 
	$"../CanvasLayer/Label".text = "Health: " + str(health) + "\n Can Dash : " + str(dash_available) + "\n Can Bounce: " + str(bounce_available)
	
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = Jump_Velocity
		
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
		#print(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
			
	anims(direction)
	attacks()
	move_and_slide()
	if is_on_floor() and slamming:
		
		$Area2D2/AnimatedSprite2D.position.y = $Sprite2D.position.y + 500
		$Area2D2/AnimatedSprite2D.set_frame(1)
		$Area2D2/AnimatedSprite2D.play("default")
		slamming = false
		
	if innpc == true and Iframe == 0:
		health -= 1
		print(str(health) + " health")
		Iframe = 40

	if Iframe > 0:
		Iframe -= 1

var bounce_available = true
var dash_available = true
@export var dash: int = 19
@export var slamv: int = 2000
var slamming = false

func bouncecd():
	bounce_available = false
	await get_tree().create_timer(2).timeout
	bounce_available = true


func dashcd():
	dash_available = false
	await get_tree().create_timer(.7).timeout
	dash_available = true
	await is_on_floor

func attacks():
	if not is_on_floor():
		if dash_available == true and Input.is_action_just_pressed("Dash"):
			
			velocity.x *= dash
			print(velocity.x)
			dashcd() 
			
		if Input.is_action_just_pressed("S"):
			slamming = true
			velocity.y = slamv
	if Input.is_action_just_pressed("W"):
		if is_on_floor():
			pass
	if not is_on_floor():
		if Input.is_action_just_pressed("B") and bounce_available:
			velocity.y -= randf_range(500,600)
			velocity.x += randf_range(-1200,1200)
			bouncecd()

var _overlapping = []

func _process_physics(delta):
	for body in _overlapping:
		body.take_damage()

#detects when entering/exiting npc dmg radius
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		innpc = true
		print("entered")

func _on_area_2d_body_exited(body: Node2D) -> void:
	innpc = false
