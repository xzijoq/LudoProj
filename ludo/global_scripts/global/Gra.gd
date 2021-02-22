extends Node


var Sc_Sz=Vector2.ZERO
var CellSize:float
var Scale_l=Vector2.ZERO

var MarginPercent=2 #use this to scale and move the top node

var MinBotRow=2
var MinTopRow=2


#updated only by BoardCells.gd
var BoardStart:=Vector2.ZERO
var BoardEnd:=Vector2.ZERO
var BCells
var BoardRotation:=0
#end

const GSIZE    	  :int=64;	
const LudoBoard=[
	6, 7, 8, 23, 38, 53, 68, 83,                                     # 0-7
	99, 100, 101, 102, 103, 104, 119, 134, 133, 132, 131, 130, 129,  # 8-20
	143, 158, 173, 188, 203, 218, 217, 216, 201, 186, 171, 156,
	141,                                                        # 21-33
	125, 124, 123, 122, 121, 120, 105, 90, 91, 92, 93, 94, 95,  # 34-46
	81, 66, 51, 36, 21,                                         # 47-51
	# inSideSafe
	22, 37, 52, 67, 82,       # 52-56
	118, 117, 116, 115, 114,  # 57-61
	202, 187, 172, 157, 142,  # 62-66
	106, 107, 108, 109, 110,  # 67-71

	Gl.START_POSI, Gl.END_POSI ];

const SpawnPoint=[ 12, 192, 180, 0 ];

#these are readonly once defined in ready in this class



func _ready():
	
	SetGameScale()
	pass

var isY=0
func SetGameScale():
	Sc_Sz=get_viewport().size
	#if x is 15 ,y > 18
	var Extra=Gl.MAX_ROW+MinBotRow+MinTopRow
	if Gl.MAX_ROW*Sc_Sz.y > Extra*Sc_Sz.x:
		CellSize=Sc_Sz.x/Gl.MAX_ROW
		isY=1

	else:
		isY=2
		CellSize=Sc_Sz.y/Extra
	
	Scale_l=Vector2(CellSize/GSIZE,CellSize/GSIZE)



