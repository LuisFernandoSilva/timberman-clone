extends Node2D



func _ready():
	
	pass
	
func destroy(direction):
	
	if direction == -1:
		get_node("animationMoveSide").play("left")
		
	if direction == 1:
		get_node("animationMoveSide").play("right")
	
