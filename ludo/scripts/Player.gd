extends Node2D

#Scales Dont Scale Children
var PlId:=-1 setget setPlId 

var BRect:=Rect2(20,20,400,400) setget setBRect
var Psp=[preload("res://assets/PlayerIcons/p0.png")
		,preload("res://assets/PlayerIcons/p1.png")
		,preload("res://assets/PlayerIcons/p2.png")
		,preload("res://assets/PlayerIcons/p3.png")]

var PPosi=[Vector2.ZERO,Vector2.ZERO,Vector2.ZERO,Vector2.ZERO]
var GPosi=[Vector2.ZERO,Vector2.ZERO,Vector2.ZERO,Vector2.ZERO]
func _ready():
	#PPosi.resize(4)#playerNum
	var _aww=get_viewport().connect("size_changed",self,"vSchanged")
	self.scale=Gra.Scale_l
	GetReady()
	pass

func GetReady():

	$p.texture=Psp[PlId]
	$p.scale=Gra.Scale_l*2

	SetGotiz()
	SetInBoard()
	PlaceGotiz()
	for i in get_children():
		if "GoId" in i:
			i.PlIdg=PlId


func SetGotiz():
	var id:int=0
	for i in range(get_child_count()):
		if "GoId" in get_child(i):
			get_child(i).GoId=id
			id+=1
			GPosi.append(Vector2.ZERO)


func SetInBoard():
	SetPPosi()
	#self.position=Gra.BoardStart/2
	self.position=PPosi[(PlId+Gra.BoardRotation)%4]


func SetPPosi():
	var SqSz=Vector2(Gra.CellSize*(Gl.MAX_ROW-3)/2,Gra.CellSize*(Gl.MAX_COL-3)/2)
	BRect.size=SqSz
	PPosi[3]=Gra.BoardStart+SqSz/2
	PPosi[0]=Gra.BoardStart+SqSz/2+Vector2(SqSz.x+Gra.CellSize*3,  0)
	PPosi[1]=Gra.BoardStart+SqSz/2+SqSz+Vector2(Gra.CellSize*3,Gra.CellSize*3)
	PPosi[2]=Gra.BoardStart+SqSz/2+ Vector2(0,  SqSz.y+Gra.CellSize*3)


	

func PlaceGotiz():
	var offset=self.position-BRect.size/2

	GPosi[0]= offset+	BRect.size/4
	GPosi[1]= offset+	Vector2(BRect.size.x*3/4,BRect.size.y/4)
	GPosi[2]= offset+	Vector2(BRect.size.x/4,BRect.size.y*3/4)
	GPosi[3]= offset+	BRect.size*3/4

	for i in range(get_child_count()):
		if "GoId" in get_child(i):
			get_child(i).StartPosi=GPosi[i]
			get_child(i).global_position=GPosi[i]



func vSchanged():
	$p.scale=Gra.Scale_l*2
	self.scale=Gra.Scale_l
	SetInBoard()


func setPlId(value):
	PlId=value
	GetReady()

func setBRect(value):
	BRect=value

func _process(_delta):

	if Input.is_action_just_pressed("l_click"):

	
		pass
	if Input.is_action_pressed("r_click"):
		#UpdateGoti()

		get_child(1).Selected=1;
		pass
	$p.global_position=self.position

	SetInBoard()


