extends CollisionShape2D

func _ready():
	print($"../../Player".global_position)
	print($"../../Player/CollisionShape2D".global_position)
	print($"../../Player".global_position - $"../../Player/CollisionShape2D".global_position)

 
func _on_area_2d_area_entered(_area: Area2D) -> void:
	print("fallen")
	$"../../Player".velocity.y = 0
	
	
	$"../../Player".velocity.y = 0
	print($"../../Player".global_position)
	print($"../../Checkpoint1".global_position)
	$"../../Player".global_position = $"../../Checkpoint1".global_position
	$"../../Player/Sprite2D/AnimatedSprite2D".global_position = $"../../Checkpoint1".global_position
	$"../../Player/Sprite2D".global_position = $"../../Checkpoint1".global_position
	
	$"../../Player/CollisionShape2D" .global_position = $"../../Checkpoint1".global_position
	$"../../Player/Area2D2".global_position = $"../../Checkpoint1".global_position
	$"../../Player/Area2D2/CollisionShape2D".global_position = $"../../Checkpoint1".global_position - Vector2(198,460)
	print(str($"../../Player/Area2D2/CollisionShape2D".global_position) + " Col")
	$"../../Player/Area2D2/AnimatedSprite2D".global_position = $"../../Checkpoint1".global_position
	
	
	
	
	
	
	
	
	
	print($"../../Player".global_position)
	print($"../../Player/Sprite2D/AnimatedSprite2D".global_position)
