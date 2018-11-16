extends Node2D

onready var marc = get_node("markers")

var percent = 1

signal lose

func _ready():
	set_process(true)

func _process(delta):
	if percent > 0:
		percent -= 0.1*delta
		marc.set_region_rect(Rect2(0,0, percent*188, 23))
		#faz o deslocamento da barra pra esquerda
		marc.set_pos(Vector2(-(1-percent)*188/2, 0))
	else:
		emit_signal("lose")
		
func addBar(delta):
	percent += delta
	if percent > 1: percent = 1