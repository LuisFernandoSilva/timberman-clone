extends Node2D

onready var stop = get_node("stop")
onready var pouding = get_node("pouding")
onready var rip = get_node("rip")
onready var animation = get_node("poudingAnimation")

var side

const LEFT = -1
const RIGHT = 1


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func left():
	set_pos(Vector2(220,1070))
	stop.set_flip_h(false)
	pouding.set_flip_h(false)
	
	rip.set_pos(Vector2(-44,41))
	rip.set_flip_h(true)
	side= LEFT
	
func right():
	set_pos(Vector2(500,1070))
	stop.set_flip_h(true)
	pouding.set_flip_h(true)
	
	rip.set_pos(Vector2(28,41))
	rip.set_flip_h(false)
	side = RIGHT
	
func pouding():
	animation.play("poudingAnim")
	
