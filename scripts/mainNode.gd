extends Node

var barrel = preload("res://scenes/barrel.tscn")
var barrelEnemyLeft = preload("res://scenes/barrelEnemyLeft.tscn")
var barrelEnemyRight = preload("res://scenes/barrelEnemyRight.tscn")

onready var timberman = get_node("timberman")
onready var camera = get_node("camera")
onready var barrels = get_node("barrels")
onready var destBarrels = get_node("destBarrels")
onready var bar = get_node("bar")
onready var scoreLabel = get_node("control/score")

var score = 0
var lastEnemy
var state = PLAY 

const PLAY = 1
const LOSE = 2

func _ready():
	randomize()
	#ativa o touch na tela
	set_process_input(true) 
	spawnInit()
	bar.connect("lose", self, "lose")
	

func _input(event):
	#converte o evento em um evento da camera
	event = camera.make_input_local(event)
	if event.type == InputEvent.SCREEN_TOUCH and event.pressed and state == PLAY:
	
		if event.pos.x < 300:
		 	timberman.left()
		else:
			timberman.right()
			
		if !check():
			timberman.pouding()
			var first = barrels.get_children()[0]
			barrels.remove_child(first)
			destBarrels.add_child(first)
			print(timberman.side)
			first.destroy(timberman.side)
			randowBarrels(Vector2(360, 1090 - 10*172))
			downMove()
			bar.addBar(0.014)
			score +=1
			scoreLabel.set_text(str(score))
			
			if check():
				lose()
		else:
			lose()
		
func randowBarrels(pos):
	var num = rand_range(0,3)
	if lastEnemy: num = 0
	
	spawnBarrel(int(num),pos)
	
	
func spawnBarrel(type, pos):
	var newBarrel
	if type == 0:
		newBarrel = barrel.instance()
		lastEnemy = false
	elif type == 1:
		newBarrel = barrelEnemyLeft.instance()
		lastEnemy = true
		newBarrel.add_to_group("barrelEnemyLeft")#cria o grupo pra identificar depois
	elif type == 2:
		newBarrel = barrelEnemyRight.instance()
		lastEnemy = true 
		newBarrel.add_to_group("barrelEnemyRight")
	
	newBarrel.set_pos(pos)
	barrels.add_child(newBarrel)     

func spawnInit():
	
	for i in range(0, 3):
		spawnBarrel(0, Vector2(360, 1090 - i*172))#vector metade da tela no x, y = a quantidade * o tamamnho do barril
	
	for i in range(3, 10):
		randowBarrels(Vector2(360, 1090 - i*172))
		
func check():
	var side = timberman.side
	var first = barrels.get_children()[0]
	if side == timberman.LEFT and first.is_in_group("barrelEnemyLeft") or side == timberman.RIGHT and first.is_in_group("barrelEnemyRight"):
		return true
	else:
		return false
		
func downMove():
	for b in barrels.get_children():
		b.set_pos(b.get_pos() + Vector2(0,172)) # soma o tamamho de cda barril pra poder descer no y
		
		
func lose():
	timberman.dead()
	bar.set_process(false)
	state = LOSE
	get_node("restartTimer").start()

func _on_restartTimer_timeout():
	get_tree().reload_current_scene()
