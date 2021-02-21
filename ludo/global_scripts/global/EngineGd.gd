extends Node2D

signal _on_Move(plId,goId,to)
signal _on_ValidInput(player,goti)
signal _on_TurnEnd()

var EngineCpp=preload("res://engine_cpp/GameEngine.gdns")
var fuckem=preload("res://engine/engine.gd")
var En

var VInp=[]
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
	VInp.resize(8)
	En=EngineCpp.new()
	#En=fuckem.new()
	OS.window_position.x=2525


	#var _aww1=connect("_on_MoveIt",Sigil,"OnMoveIt")
	#var _yaw1=Sigil.connect("GotiClickedS",self,"GotiInput")
	#var _baa=connect("_on_ValidInput",Sigil,"OnEnablePG")

	#yield(get_tree(),"idle_frame")
	En.call("StartGame")

	#EnableAll()
	#enable all

	#enablePlayer0
	yield(get_tree(),"idle_frame")
	for i in range(4):
		emit_signal("_on_ValidInput",0,i)
		VInp[Player]=0
		VInp[Go1]=1
		VInp[Go2]=1
		VInp[Go3]=1
		VInp[Go0]=1
	
	#var mov=En.call("PGclicked",2,2)	
	#MovePG(1,2,22)


	#DebugPrintInp(inp)
	pass

func EnableAll():
	for i in range(4):
		for j in range(4):
			emit_signal("_on_ValidInput",i,j)

func StartTurn():
	var inp=En.call("GetValidInp");
	#DebugPrintInp(inp)
	#print(inp[Player])
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

	VInp.clear()
	VInp=En.call("PGclicked",goti.PlIdg,goti.GoId)	

	var mv =VInp
	#print(mv)
	for i in range(VInp.size()):
		#print(mov)
		MovePG(mv[i][0],mv[i][1],mv[i][2])
	


	En.call("EndTurnE")
	emit_signal("_on_TurnEnd")
	#EnableAll()
	StartTurn()
	#print("---------turnsTrt")
	pass


func GetSq(sq):
	var SqPg=En.call("GetSquare",sq)
	return SqPg

func MovePG(Pl,Go,to):
	emit_signal("_on_Move",Pl,Go,to)
	pass

	
func _process(_delta):

	if Input.is_action_just_released("l_click"):
		self.DiceRoll+=1

	if Input.is_action_just_pressed("quit"):
		get_tree().quit();
		#MovePG(1,0,DiceRoll)
