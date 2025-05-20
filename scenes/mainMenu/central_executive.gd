extends Node2D
var team=[]
var frameCounter=0
var rotationSpeeds=[]
var centerClones=[]
var tide=true
var tav=preload("res://scenes/characterList/randomObject.tscn")
func _physics_process(delta: float) -> void:
	get_node("galaxyCenter").rotation_degrees=frameCounter/2
	get_node("galaxyCenter/theSun").rotation_degrees=frameCounter/2
	get_node("galaxyCenter/theSun/theMoon").rotation_degrees=frameCounter*2
	var counter=0
	for clone in centerClones:
		clone.rotation_degrees=frameCounter*rotationSpeeds[counter]
		for child in clone.get_children():
			child.rotation_degrees=frameCounter*rotationSpeeds[counter]
			if tide==false:
				child.position=child.position+Vector2(0.05,0.05)
			else:
				child.position=child.position+Vector2(-0.05,-0.05)
		counter+=1
	frameCounter+=1
	if frameCounter%800==0:
		tide=!tide
func _ready():
	for i in range(15):
		var id
		var tav
		if i%2==0:
			id=randi_range(0,7)
		else:
			id=randi_range(8,15)
		if (id==0):
			tav=preload("res://scenes/characterList/timOBrien.tscn")
		elif (id==1):
			tav=preload("res://scenes/characterList/jimmy_cross.tscn")
		elif (id==2):
			tav=preload("res://scenes/characterList/kiowa.tscn")
		elif (id==3):
			tav=preload("res://scenes/characterList/norman_bowker.tscn")
		elif (id==4):
			tav=preload("res://scenes/characterList/mary_anne.tscn")
		elif (id==5):
			tav=preload("res://scenes/characterList/rat_kiley.tscn")
		elif (id==6):
			tav=preload("res://scenes/characterList/henry_dobbins.tscn")
		elif (id==7):
			tav=preload("res://scenes/characterList/linda.tscn")
		
		elif (id==8):
			tav=preload("res://scenes/characterList/gobbos.tscn")
		elif (id==9):
			tav=preload("res://scenes/characterList/grumkins.tscn")
		elif (id==10):
			tav=preload("res://scenes/characterList/strangler_figs.tscn")
		elif (id==11):
			tav=preload("res://scenes/characterList/pepperion_pigs.tscn")
		elif (id==12):
			tav=preload("res://scenes/characterList/randomObject.tscn")
		elif (id==13):
			tav=preload("res://scenes/characterList/randomObject.tscn")
		elif (id==14):
			tav=preload("res://scenes/characterList/randomObject.tscn")
		elif (id==15):
			tav=preload("res://scenes/characterList/randomObject.tscn")
		var instance=tav.instantiate()
		if id>=12:
			instance.randomNess=true
		var centerClone=get_node("galaxyCenter2").duplicate()
		add_child(centerClone)
		centerClones.append(centerClone)
		centerClone.add_child(instance)
		team.append(instance)
		for clone in centerClones:
			clone.position=clone.position+Vector2(randi_range(-10,10),randi_range(-10,10))
	for character in team:
		character.position=(character.position+Vector2(randi_range(-10,10)*12,randf_range(-10,10)*12))
		rotationSpeeds.append((7*(0.6/(character.position.distance_to(get_node("galaxyCenter").position)/100)))+randf_range(0,0.3))
		character.get_node("Sprite2D").z_as_relative=false
		
