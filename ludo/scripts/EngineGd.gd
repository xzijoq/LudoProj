extends Node2D

signal _on_MoveIt(plId,goId,to)

func _ready():
	OS.window_position.x=2525
	#$GameEngine.call( "InputClicked",1,2)
	#var omega=$GameEngine.call("GetMoves")
	#print(omega)
	var _aww1=connect("_on_MoveIt",Sigil,"OnMoveIt")
	var _yaw1=Sigil.connect("GotiClickedS",self,"GotiInput")
	pass

enum State{WaitDice,WaitSelect,Working}

var DiceRoll=68 setget SetDiceRoll
func SetDiceRoll(value):
	DiceRoll=value%74

var Turn:=0


func GotiInput(goti):
	self.DiceRoll+=1

	$GameEngine.call( "InputClicked",goti.PlIdg,goti.GoId)
	var mov=$GameEngine.call("GetMoves")
	for i in range(mov.size()):
		MovePG(mov[i][0],mov[i][1],mov[i][2])

	pass

func MovePG(Pl,Go,to):
	emit_signal("_on_MoveIt",Pl,Go,to)
	pass

	
func _process(delta):

	if Input.is_action_just_released("l_click"):
		self.DiceRoll+=1
		#MovePG(1,0,DiceRoll)
