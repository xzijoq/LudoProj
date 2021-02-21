extends Node2D
#initital draw is not based on global posi

#vars
var CellSc=preload("res://scenes/Cell.tscn")


var Xmargin=0

var Cell=[]
var Posi=[]
var Player=[];
#-vars



func _enter_tree():
	Posi.resize(Gl.MAX_ROW*Gl.MAX_COL)
	Cell.resize(Gra.LudoBoard.size())	


func _ready():
	AddCells()
	InitPosi()
	SetBoard()	

	var _aww=get_viewport().connect("size_changed",self,"vsize_changed")

	$icon1.global_position=self.position
	RotateBoard(0)
	Gra.BCells=Cell
	pass

func AddCells():
	for i in range(Gra.LudoBoard.size()) :
		Cell[i]=CellSc.instance()
		Cell[i].CellNumber=i
		add_child(Cell[i])
	
func InitPosi():
	var Xost=Gra.CellSize/2
	var Yost=Gra.CellSize/2
	var k:int=0
	for i in Gl.MAX_ROW:
		for j in Gl.MAX_COL:
			Posi[k] = Vector2(  Gra.CellSize * j +Xost ,Gra.CellSize * i +Yost );
			k+=1

	self.position.x=Gra.CellSize*Gl.MAX_ROW /2 + Xost - Gra.CellSize/2
	self.position.y=Gra.CellSize*Gl.MAX_COL /2 + Yost - Gra.CellSize/2	
	#self.position=Posi[15*7+7]
	

func SetBoard():
	self.scale=Gra.Scale_l
	for i in range(Gra.LudoBoard.size()) :
		Cell[i].global_position=Posi[Gra.LudoBoard[i]]

	self.position.x=Gra.Sc_Sz.x/2
	self.position.y+=Gra.MinTopRow*Gra.CellSize#(Gra.Sc_Sz.y-Gra.CellSize*Gra.MinBotRow)/2
	UpGraBdSz()


func UpGraBdSz():
	var cell=[Cell[41],Cell[0],Cell[15],Cell[26]]
	#its rotation of cells need better way to do that matrix may be
		#match Gra.BoardRotation:
		#	0:
		#		cell=[Cell[41],Cell[0],Cell[15],Cell[26]]
		#	1:
		#		cell=[Cell[26],Cell[41],Cell[0],Cell[15],]
		#	2:
		#		cell=[Cell[15],Cell[26],Cell[41],Cell[0]]
		#	3:
		#		cell=[Cell[0],Cell[15],Cell[26],Cell[41]]

	Gra.BoardStart=Vector2( cell[(0)].global_position.x-Gra.CellSize/2,
							cell[(1)].global_position.y-Gra.CellSize/2)
	Gra.BoardEnd  =Vector2 (cell[(2)].global_position.x+Gra.CellSize/2,
							cell[(3)].global_position.y+Gra.CellSize/2)
func RotateBoard(angle:int):
	if !(angle>=0 && angle<4):
		print("angle out of bound")
		angle=angle%4

	self.global_rotation_degrees=(angle*90)
	for i in get_children():	
		i.rotation_degrees=-angle*90
		pass
	Gra.BoardRotation=angle
	


		
var io=0
func _process(_delta):
	if Input.is_action_just_pressed("l_click"):

		io+=1
		#RotateBoard(io%4)

	if Input.is_action_pressed("r_click"):
		#self.position.x+=1
		#UpGraBdSz()
		#print(Cell[0].global_position)
		pass
	#update()


func vsize_changed():
	var ro=Gra.BoardRotation
	Gra.SetGameScale()
	#Gra.BoardRotation=0
	RotateBoard(0)
	InitPosi()
	SetBoard()
	#yield(get_tree(),"idle_frame")
	RotateBoard(ro)

	#UpGraBdSz()








