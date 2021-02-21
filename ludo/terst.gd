extends Node2D



var mouseOn1  =false
var mouseOn2  =false

var a1=false
var a2=false

func _ready():
	pass
func _a1():
	mouseOn1=true


func _a2():
	mouseOn2=true

func _a1e():
	mouseOn1=false
	pass
func _a2e():
	mouseOn2=false
	pass

func _process(delta):

	if mouseOn1==true &&Input.is_action_just_pressed("l_click"):
		print("a1click")
	if mouseOn2==true &&Input.is_action_just_pressed("l_click"):
		print("a2click")
