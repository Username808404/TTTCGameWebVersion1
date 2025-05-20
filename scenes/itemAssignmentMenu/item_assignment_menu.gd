extends Control
var selectingTeamComp=[]
var itemList=[]
var selectedItems=[-1,-1,-1,-1]
var backupItems=[8,9]
var x=15*12
var y=19*12
var first=true
func _ready() -> void:
	MusicManager.papers.stop()
	MusicManager.lotus.stop()
	MusicManager.initializeChrono()
	selectingTeamComp=global.team0
	_gridUpdate()
	_announcerUpdate()


func _moveOn():
	get_tree().change_scene_to_file("res://scenes/preBattleMenu/preBattleMenu.tscn")

func _gridUpdate():
	var x2=x
	for i in selectingTeamComp:
		_anythingAnywhere(i,Vector2(x2,y), true)
		x2+=8*12
		if (i<=7):
			var end=itemList.size()-1
			if end<0:
				end=0
			itemList.insert(randi_range(0,end),i)
	if itemList.size()==0 and backupItems.size()>0:
		itemList.append(backupItems[0])
		backupItems.remove_at(0)
		
	
func _announcerUpdate():
	get_node("Node2D/cowardice").visible=false
	get_node("Node2D/prism").visible=false
	get_node("Node2D/hatchet").visible=false
	get_node("Node2D/purple").visible=false
	get_node("Node2D/wild").visible=false
	get_node("Node2D/medkit").visible=false
	get_node("Node2D/machinegun").visible=false
	get_node("Node2D/spirit").visible=false
	get_node("Node2D/relic").visible=false
	get_node("Node2D/time").visible=false


	if itemList.size()>0:
		if itemList[0]==0:
			get_node("Node2D/cowardice").visible=true
			get_node("announcer").text="Player " + str(global.selectingTeam+1) + ", who shall receive the [color=gold]Cowardice of Conformity[/color]?"
		elif itemList[0]==1:
			get_node("Node2D/prism").visible=true
			get_node("announcer").text="Player " + str(global.selectingTeam+1) + ", who will treasure the [color=lightskyblue]Prismatic Pebble[/color]?"
		elif itemList[0]==2:
			get_node("Node2D/hatchet").visible=true
			get_node("announcer").text="Player " + str(global.selectingTeam+1) + ", who do you arm with a [color=silver]Sanctified Hatchet[/color]?"
		elif itemList[0]==3:
			get_node("Node2D/purple").visible=true
			get_node("announcer").text="Player " + str(global.selectingTeam+1) + ", who do you reward with the [color=purple]Heart of Purple[/color]?"
		elif itemList[0]==4:
			get_node("Node2D/wild").visible=true
			get_node("announcer").text="Player " + str(global.selectingTeam+1) + ", who becomes the [color=lime]Wilderness[/color]?"
		elif itemList[0]==5:
			get_node("Node2D/medkit").visible=true
			get_node("announcer").text="Player " + str(global.selectingTeam+1) + ", who deserves the [color=firebrick]Medicine Kit[/color]?"
		elif itemList[0]==6:
			get_node("Node2D/machinegun").visible=true
			get_node("announcer").text="Player " + str(global.selectingTeam+1) + ", who do you arm with an [color=skyblue]M-60 Machine Gun[/color]?"
		elif itemList[0]==7:
			get_node("Node2D/spirit").visible=true
			get_node("announcer").text="Player " + str(global.selectingTeam+1) + ", who shall receive [color=aquamarine]21 Grams of a Human Soul[/color]?"
			
		elif itemList[0]==8: # FOR SQUADS OF MINIONS ONLY 
			get_node("Node2D/time").visible=true
			get_node("announcer").text="Player " + str(global.selectingTeam+1) + ", who shall obtain [color=mistyrose]8 Seconds of Unused Time[/color]?"
			
		elif itemList[0]==9: # FOR SQUADS OF MINIONS ONLY 
			get_node("Node2D/relic").visible=true
			get_node("announcer").text="Player " + str(global.selectingTeam+1) + ", who receives [color=dodgerblue]Platinum Tier Trauma Team Health Insurance[/color]?"

func _on_button_1_pressed() -> void:
	selectedItems[0]=itemList[0]
	itemList.remove_at(0)
	checkup()

func _on_button_2_pressed() -> void:
	selectedItems[1]=itemList[0]
	itemList.remove_at(0)
	checkup()

func _on_button_3_pressed() -> void:
	selectedItems[2]=itemList[0]
	itemList.remove_at(0)
	checkup()

func _on_button_4_pressed() -> void:
	selectedItems[3]=itemList[0]
	itemList.remove_at(0)
	checkup()

func checkup() -> void: 
	_announcerUpdate()
	if itemList.size()==0:
		if global.selectingTeam==0:
			global.team0Items=selectedItems
			global.selectingTeam=1
			selectingTeamComp=global.team1
			
		elif global.selectingTeam==1:
			global.team1Items=selectedItems
			global.selectingTeam=2
			selectingTeamComp=global.team2
			
		elif global.selectingTeam==2:
			global.team2Items=selectedItems
			global.selectingTeam=3
			selectingTeamComp=global.team3
	
		elif global.selectingTeam==3:
			global.team3Items=selectedItems
			_moveOn()
		_gridUpdate()
		_announcerUpdate()
		selectedItems=[-1,-1,-1,-1]
		if selectingTeamComp.size()==0:
			_moveOn()
		
			
func _anythingAnywhere(id, coordinates, assignmentScale):
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
		instance.get_node("Sprite2D").scale=Vector2(4,4)
		instance.get_node("TextureButton").scale=Vector2(4,4)
		instance.get_node("TextureButton").position=Vector2(-24,-24)
		add_child(instance)
