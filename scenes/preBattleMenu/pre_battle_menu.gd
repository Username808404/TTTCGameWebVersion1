extends Control
func _ready():
	global.challengers=[false,false,false,false]
	#global.team0=[0,1,2,3] #DELETE 4-7 ON REAL RELEASE 
	#global.team1=[8,9,10,11]
	#global.team2=[4,5,6,7]
	#global.team3=[8,9,10,11]
	var x=5*12
	var y=12*12
	for i in global.team0:
		_anythingAnywhere(i, Vector2(x,y),true,false)
		x=x+12*5
	x+=12*7
	for i in global.team1:
		_anythingAnywhere(i, Vector2(x,y), true,true)
		x=x+12*5
		
	x=5*12
	y=22*12
	if global.team2.size()>0:
		get_node("Button3").visible=true
		for i in global.team2:
			_anythingAnywhere(i, Vector2(x,y),true,false)
			x=x+12*5
	x+=12*7
	if global.team3.size()>0:
		get_node("Button4").visible=true
		for i in global.team3:
			_anythingAnywhere(i, Vector2(x,y),true,true)
			x=x+12*5
	
func _anythingAnywhere(id, coordinates, assignmentScale, flip):
	var tav
	if (id==0):
		tav=preload("res://scenes/characterList/timOBrien.tscn")
	if (id==1):
		tav=preload("res://scenes/characterList/jimmy_cross.tscn")
	if (id==2):
		tav=preload("res://scenes/characterList/kiowa.tscn")
	if (id==3):
		tav=preload("res://scenes/characterList/norman_bowker.tscn")
	if (id==4):
		tav=preload("res://scenes/characterList/mary_anne.tscn")
	if (id==5):
		tav=preload("res://scenes/characterList/rat_kiley.tscn")
	if (id==6):
		tav=preload("res://scenes/characterList/henry_dobbins.tscn")
	if (id==7):
		tav=preload("res://scenes/characterList/linda.tscn")
	
	if (id==8):
		tav=preload("res://scenes/characterList/gobbos.tscn")
	if (id==9):
		tav=preload("res://scenes/characterList/grumkins.tscn")
	if (id==10):
		tav=preload("res://scenes/characterList/strangler_figs.tscn")
	if (id==11):
		tav=preload("res://scenes/characterList/pepperion_pigs.tscn")
	if (id==12):
		tav=preload("res://scenes/characterList/ghosts.tscn")
	if (id==13):
		tav=preload("res://scenes/characterList/snakes.tscn")
	if (id==14):
		tav=preload("res://scenes/characterList/lost_medics.tscn")
	if (id==15):
		tav=preload("res://scenes/characterList/friend.tscn")
	
	var instance=tav.instantiate()
	instance.global_position=coordinates
	if (assignmentScale==true):
		instance.get_node("Sprite2D").scale=Vector2(3,3)
		instance.get_node("TextureButton").scale=Vector2(3,3)
		instance.get_node("TextureButton").position=Vector2(-18,-18)
		add_child(instance)
	
	if (flip==true):
		instance.get_node("Sprite2D").flip_h=!instance.get_node("Sprite2D").flip_h


func _on_button_pressed() -> void:
	global.challengers[0]=!global.challengers[0]
	get_node("ColorRect").visible=!get_node("ColorRect").visible
	_check()

func _check()->void:
	var count=0
	for i in global.challengers:
		if i==true:
			count+=1
	if count==2:
		get_node("battleButton").visible=true
	else:
		get_node("battleButton").visible=false
func _on_battle_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/battle/battle.tscn")

func _on_button_2_pressed() -> void:
	global.challengers[1]=!global.challengers[1]
	get_node("ColorRect2").visible=!get_node("ColorRect2").visible
	_check()
	
func _on_button_3_pressed() -> void:
	global.challengers[2]=!global.challengers[2]
	get_node("ColorRect3").visible=!get_node("ColorRect3").visible
	_check()

func _on_button_4_pressed() -> void:
	global.challengers[3]=!global.challengers[3]
	get_node("ColorRect4").visible=!get_node("ColorRect4").visible
	_check()
