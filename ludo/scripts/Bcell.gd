extends GridContainer


#initital draw is not based on global posi

#vars
var CellSc=preload("res://scenes/Cell.tscn")

var ParentRect:=Vector2.ZERO
var CellSize:float=0
var Scale_l:=Vector2.ZERO

const GSIZE    	  :int=64;	
var Xmargin=0

func UpdateScaleMain():

	ParentRect=rect_size

	CellSize=(ParentRect.x-Xmargin)/(Gl.MAX_ROW) 
	Scale_l=Vector2(CellSize/GSIZE,CellSize/GSIZE)


var Cell=[]
var BCell=[];
var Posi=[];
var Player=[];


#-vars
func _enter_tree():
	Posi.resize(Gl.MAX_ROW*Gl.MAX_COL)
	Cell.resize(225)#(Gra.LudoBoard.size())	

func _ready():
#	yield(get_tree(),"idle_frame")

	UpdateScaleMain()
	#var _aww=get_viewport().connect("size_changed",self,"vsize_changed")
	InitPosi()
	DrawBoard()	

	#RotateBoard(90)
	#self.rect_pivot_offset=self.rect_size/2
	#$icon.rect_position=self.rect_pivot_offset
	pass


func vsize_changed():
	UpdateScaleMain()
	InitPosi()
	print(Scale_l)
	for i in range(Gra.LudoBoard.size()) :
		Cell[i].rect_position=Posi[Gra.LudoBoard[i]]
		Cell[i].rect_scale=Scale_l
	#self.scale=Scale_l
	pass


func InitPosi():

	var k:int=0
	var Xost:float=0#CellSize/2
	var Yost:float=0#CellSize/2
	for i in Gl.MAX_ROW:
		for j in Gl.MAX_COL:
			Posi[k] = Vector2( CellSize * j + Xost, CellSize * i + Yost );
			k+=1
	self.rect_pivot_offset=Posi[15*7+7]
	#self.rect_pivot_offset.x=((CellSize*Gl.MAX_ROW) / 2)  -(CellSize/2)+Xost
	#self.rect_pivot_offset.y=((CellSize*Gl.MAX_COL) / 2)  -(CellSize/2)+Yost
	#self.scale=Scale_l

func RotateBoard(angle):
		self.rect_rotation=( angle)
		for i in get_children():	
			if i is TextureRect:			
				pass
				#i.rect_rotation=-angle
			pass
	

func _process(_delta):
	if Input.is_action_pressed("l_click"):
		pass
		#self.position.x+=1

func DrawBoard():
	for i in 225:#range(Gra.LudoBoard.size()) :
		Cell[i]=CellSc.instance()
		Cell[i].CellNumber=i

		#Cell[i].rect_scale=Scale_l
		add_child(Cell[i])
		#Cell[i].rect_position=Posi[Gra.LudoBoard[i]]
	#self.scale=Scale_l
func DrawBaseBoard():
	pass


	



