extends Node2D

func _ready():
	#WorldMargin()
	pass

func WorldMargin():
	var Displacement
	Displacement= Gra.Sc_Sz.x*Gra.MarginPercent/100
	scale=scale*(100-Gra.MarginPercent)/100
	position.x+=Displacement/2
	position.y+=Displacement/2
func _draw():
	var BCRect=Rect2(0,0,0,0)
	BCRect.position=Gra.BoardStart
	BCRect.size=Gra.BoardEnd-BCRect.position
	draw_rect(BCRect,Color.aliceblue,false)

func _physics_process(_delta):
	update()