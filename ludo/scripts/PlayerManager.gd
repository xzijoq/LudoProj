extends Node2D


func _ready():
	for i in get_child_count():
		get_child(i).PlId=i

	pass
