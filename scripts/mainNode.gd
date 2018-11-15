extends Node

onready var timberman = get_node("timberman")
onready var camera = get_node("camera")

func _ready():
	#ativa o touch na tela
	set_process_input(true) 

func _input(event):
	#converte o evento em um evento da camera
	event = camera.make_input_local(event)
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed:
	
		if event.pos.x < 300:
		 	timberman.left()
		else:
			timberman.right()
		
		timberman.pouding()
	     
