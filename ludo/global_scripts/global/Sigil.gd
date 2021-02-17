extends Node

#connected by GameEngine
signal GotiClickedS(which)
signal EnablePG(pl,go)
func OnGotiClicked(goti):
	#connected by goti node
	emit_signal("GotiClickedS",goti)


#connected by goti (currently broadcast)
#may be need by player or player manager or board	
signal MoveItS(plId,goId,where)	
func OnMoveIt(pl,go,cellNumber):
	#connected by GameEngine
	emit_signal("MoveItS",pl,go,cellNumber)

func OnEnablePG(plID,goID):
	emit_signal("EnablePG",plID,goID)
	pass


