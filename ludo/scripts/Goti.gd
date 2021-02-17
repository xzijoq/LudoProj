extends Area2D
class_name Goti


var Selected:=0 setget set_Selected
var GoId:=-1 setget set_GoId 
var PlIdg=-1 setget set_PlIdg
var StartPosi=Vector2.ZERO

signal _on_Goti_Clicked(which)

var Psp=[preload("res://assets/PlayerIcons/p0.png")
		,preload("res://assets/PlayerIcons/p1.png")
		,preload("res://assets/PlayerIcons/p2.png")
		,preload("res://assets/PlayerIcons/p3.png")]

func _ready():
	$Button.set_deferred("disabled",true)
		#scale=Gra.Scale_l

	var _aww=get_viewport().connect("size_changed",self,"vSizeChanged")
	var _aww1=connect("_on_Goti_Clicked",Sigil,"OnGotiClicked")
	var _gaw1=Sigil.connect("MoveItS",self,"MoveIt")
	var _baa=Sigil.connect("EnablePG",self,"Enable")

	if "PlId" in get_parent():
		self.PlIdg=get_parent().PlId
	
	ColorMe()
	SetSprite()
	pass



func Enable(plId,goId):

	if plId==PlIdg && goId==GoId:
		#print("plid: ",PlIdg," Goid: ",GoId)
		self.Selected=1
	elif plId!=PlIdg:
		self.Selected=0

	pass

func MoveIt(plID,goID,cell):
	if plID==PlIdg && goID==GoId:
		MoveTo(cell)
	pass

func set_Selected(value):
	Selected=value;
	if Selected!=0:
		$Button.set_deferred("disabled",false)
		$Sprite.self_modulate=Color("ffffff");
	else:
		$Button.set_deferred("disabled",true)
		ColorMe()
	pass
func MoveTo(cell):
	if cell ==Gl.START_POSI && StartPosi!=Vector2.ZERO:
		self.global_position=StartPosi
		pass
	elif Gra.BCells!=null:
		self.global_position=Gra.BCells[cell].global_position
	
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
	#print(GoId)
	self.Selected=0
	emit_signal("_on_Goti_Clicked",self)
	pass # Replace with function body.
func vSizeChanged():
	pass
	#scale=Gra.Scale_l




