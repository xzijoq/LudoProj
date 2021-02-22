extends Label


func _ready():

	yield(get_tree(),"idle_frame")
	text=String (Gra.Sc_Sz.x) + " y "+ String(Gra.Sc_Sz.y)+" "+ String(Gra.isY)

	pass
