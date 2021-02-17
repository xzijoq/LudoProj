extends Node2D

signal _on_MoveIt(plId,goId,to)

signal _on_ValidInput(player,goti)
enum {
	Error,
	Roll,
	Player,
	Go0,
	Go1,
	Go2,
	Go3
}
#var inp=[]
func _ready():
	
	OS.window_position.x=2525
	#$GameEngine.call( "InputClicked",1,2)
	#var omega=$GameEngine.call("GetMoves")
	#print(omega)

	var _aww1=connect("_on_MoveIt",Sigil,"OnMoveIt")
	var _yaw1=Sigil.connect("GotiClickedS",self,"GotiInput")
	var _baa=connect("_on_ValidInput",Sigil,"OnEnablePG")

	yield(get_tree(),"idle_frame")
	StartTurn();
	#DebugPrintInp(inp)
	pass

func StartTurn():
	var inp=$GameEngine.call("GetValidInp");
	#DebugPrintInp(inp)
	for i in range(4):
		if inp[i+3]!=0:
			emit_signal("_on_ValidInput",inp[Player],i)
	pass



func DebugPrintInp(var i):
	print(" Player: ",i[Player]," Roll: ",i[Roll]);
	print(" Pieces: ",i[Go0],i[Go1],i[Go2],i[Go3])

enum State{WaitDice,WaitSelect,Working}

var DiceRoll=68 setget SetDiceRoll
func SetDiceRoll(value):
	DiceRoll=value%74

var Turn:=0


func GotiInput(goti):
	self.DiceRoll+=1

	$GameEngine.call( "InputClicked",goti.PlIdg,goti.GoId)
	#var mov=$GameEngine.call("GetMoves")
	var mov=$GameEngine.call("PGclicked",goti.PlIdg,goti.GoId)	
	for i in range(mov.size()):
		#print(mov)
		MovePG(mov[i][0],mov[i][1],mov[i][2])
	
	StartTurn()
	pass

func MovePG(Pl,Go,to):
	emit_signal("_on_MoveIt",Pl,Go,to)
	pass

	
func _process(_delta):

	if Input.is_action_just_released("l_click"):
		self.DiceRoll+=1

	if Input.is_action_just_pressed("quit"):
		get_tree().quit();
		#MovePG(1,0,DiceRoll)
