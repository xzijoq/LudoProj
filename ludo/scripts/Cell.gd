extends Node2D
var CellSp=preload("res://assets/PlayerIcons/cell.png")
var SfCellSp=preload("res://assets/PlayerIcons/WHite.png")
var CellNumber:int=0 setget SetCellNumber

func SetCellNumber(value):
	CellNumber=value
	
	$Label.text=String(CellNumber)
	for i in Gl.SafeSq:
		if CellNumber==i:
			$Sprite.texture=SfCellSp
			
			$Sprite.self_modulate=Color("5affffff")
	pass
func _ready():
	
	$Label.text=String(CellNumber)
	pass
