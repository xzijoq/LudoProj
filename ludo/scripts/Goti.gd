extends Area2D
class_name Goti


var Selected:=1 setget set_Selected
var GoId:=-1 setget set_GoId 
var PlIdg=-1 setget set_PlIdg

var CellNum=-1
#	15*6+7,15*7+6,15*7+8,15*8+7,
var StartPosi=Vector2.ZERO

var InputDelay=Timer.new()

signal _on_Goti_Clicked(which)

var Psp=[preload("res://assets/PlayerIcons/p0.png")
		,preload("res://assets/PlayerIcons/p1.png")
		,preload("res://assets/PlayerIcons/p2.png")
		,preload("res://assets/PlayerIcons/p3.png")]

func _ready():
	InputDelay.wait_time=0.5 
	InputDelay.one_shot=true
	add_child(InputDelay)
	#$Button.set_deferred("disabled",true)
		#scale=Gra.Scale_l


	var _aww1=connect("_on_Goti_Clicked",EngineGd,"GotiInput")
	var _gaw1=EngineGd.connect("_on_Move",self,"MoveIt")
	var _baa=EngineGd.connect("_on_ValidInput",self,"Enable")
	var _ya=EngineGd.connect("_on_TurnEnd",self,"OnTurnEnd")

	if "PlId" in get_parent():
		self.PlIdg=get_parent().PlId
	
	ColorMe()
	SetSprite()
	pass



func Enable(plId,goId):

	if plId==PlIdg && goId==GoId:

		self.Selected=1

	elif plId!=PlIdg:
		self.Selected=1

	pass

func OnTurnEnd():
	if(CellNum!=-1):
	
		UpdateDisplay(CellNum)
		pass
func MoveIt(plID,goID,cell):
	if plID==PlIdg && goID==GoId:
		MoveTo(cell)
	pass

func set_Selected(value):
	Selected=value;

	if Selected!=0:
		#print("plid: ",PlIdg," Goid: ",GoId," isSel ",Selected)
		$Button.set_deferred("disabled",false)
		$Button.mouse_filter=Control.MOUSE_FILTER_PASS
		$Sprite.self_modulate=Color("ffffff");
	else:
		$Button.set_deferred("disabled",true)
		$Button.mouse_filter=Control.MOUSE_FILTER_IGNORE
		ColorMe()
	pass
func MoveTo(cell):
	#basically called by EngineGd

	CellNum=cell;

	if cell ==Gl.START_POSI && StartPosi!=Vector2.ZERO:
		self.scale=Vector2(1,1)
		self.global_position=StartPosi
		pass
	elif Gra.BCells!=null:
		self.global_position=Gra.BCells[cell].global_position
	#print(Gra.BCells[cell].global_position)

func UpdateDisplay(cell):
	if cell==Gl.START_POSI:
		return
	var sqPG=EngineGd.GetSq(cell)
	#sqPG.sort()
	var sz
	var cp=Gra.BCells[cell].global_position
	var k:=-1
	if sqPG.size()==1: 
		self.scale=Vector2(1,1)
		self.global_position=cp
	elif sqPG.size()>1 && sqPG.size()<=4:
		self.scale=Vector2(1,1)/2
		sz=(Gra.GSIZE*self.global_scale)/2
		#print(sz)
		if sqPG[0]!=null && sqPG[0][0]==self.PlIdg && sqPG[0][1]==self.GoId:
			self.global_position=cp+Vector2(-sz.x,-sz.y)
			pass
		elif sqPG[1]!=null && sqPG[1][0]==self.PlIdg && sqPG[1][1]==self.GoId: 
			self.global_position=cp+Vector2(sz.x,-sz.y)
			pass
		elif sqPG[2]!=null && sqPG[2][0]==self.PlIdg && sqPG[2][1]==self.GoId: 
			self.global_position=cp+Vector2(-sz.x,sz.y)
			pass
		elif sqPG[3]!=null && sqPG[3][0]==self.PlIdg && sqPG[3][1]==self.GoId: 
			self.global_position=cp+Vector2(sz.x,sz.y)
			pass
		if sqPG.size()==2:
			self.position.y+=sz.y*2

		# center if only 2 piece sqpg==2

	elif sqPG.size()>4 && sqPG.size()<=9:
		self.scale=Vector2(1,1)/3
		sz=(Gra.GSIZE*self.global_scale)/2
		#print(sz)
		if sqPG[0]!=null && sqPG[0][0]==self.PlIdg && sqPG[0][1]==self.GoId:
			self.global_position=cp+Vector2(-sz.x*2,-sz.y*2)
			pass
		elif sqPG[1]!=null && sqPG[1][0]==self.PlIdg && sqPG[1][1]==self.GoId: 
			self.global_position=cp+Vector2(0,-sz.y*2)
			pass
		elif sqPG[2]!=null && sqPG[2][0]==self.PlIdg && sqPG[2][1]==self.GoId: 
			self.global_position=cp+Vector2(sz.x*2,-sz.y*2)
			pass
		elif sqPG[3]!=null && sqPG[3][0]==self.PlIdg && sqPG[3][1]==self.GoId: 
			self.global_position=cp+Vector2(-sz.x*2,0)
			pass
		elif sqPG[4]!=null && sqPG[4][0]==self.PlIdg && sqPG[4][1]==self.GoId: 
			self.global_position=cp+Vector2(0,0)
			pass
		elif sqPG[5]!=null && sqPG[5][0]==self.PlIdg && sqPG[5][1]==self.GoId: 
			self.global_position=cp+Vector2(sz.x*2,0)
			pass
		elif sqPG[6]!=null && sqPG[6][0]==self.PlIdg && sqPG[6][1]==self.GoId: 
			self.global_position=cp+Vector2(-sz.x*2,sz.y*2)
			pass
		elif sqPG[7]!=null && sqPG[7][0]==self.PlIdg && sqPG[7][1]==self.GoId: 
			self.global_position=cp+Vector2(0,sz.y*2)
			pass
		elif sqPG[8]!=null && sqPG[8][0]==self.PlIdg && sqPG[8][1]==self.GoId: 
			self.global_position=cp+Vector2(sz.x*2,sz.y*2)
			pass
		if sqPG.size()<7:
			self.position.y+=sz.y*2
	
	elif sqPG.size()>9 && sqPG.size()<=16:
		self.scale=Vector2(1,1)/4
		sz=(Gra.GSIZE*self.global_scale)/2
		for i in range(0,4):
			for j in range(0,4):
				k+=1

				if (k)<sqPG.size() && sqPG[k][0]==self.PlIdg && sqPG[k][1]==self.GoId:
					#print("x y: ",3-2*i," ",3-2*j," plid goid: ",PlIdg," ",GoId,"---- i j: ",i," ",j)
					self.global_position=cp+Vector2(sz.x*-(3-2*j),sz.y*-(3-2*i))
		if sqPG.size()<13:
			self.position.y+=sz.y*2
	#print("Pl",PlIdg," go",GoId)
	#print()

	pass

func SetSprite():
	$Sprite.texture=Psp[PlIdg]

func ColorMe():
	var ColorS="ffffff"
	match GoId:
		0:
			ColorS="dc0f0f" #redish
		1:
			ColorS="0fdc34"#greenish
		2:
			ColorS="0f72dc"#blueish
		3:
			ColorS="c20fdc"#purplish
	$Sprite.self_modulate=Color(ColorS)


func set_GoId(value):
	GoId=value
	ColorMe()
	pass

func set_PlIdg(value):
	PlIdg=value
	ColorMe()
	SetSprite()
	pass

func _on_Button_pressed():
	#print(self.name)
	#$Button.disabled=true

	self.Selected=0
	emit_signal("_on_Goti_Clicked",self)
	InputDelay.start()
	yield(InputDelay,"timeout")

	pass # Replace with function body.






