extends Control
var pcount=global.playerCount
var counter=0
var turnorder=[]
var words=[]
func _ready():
	for i in range(4):
		for x in range(pcount):
			turnorder.append(x+1)
	get_node("announcer").text=("Player "+str(turnorder[0])+" select your 1st squadmate")
	for i in range(pcount-1):
		words.append("1st")
	for i in range(pcount):
		words.append("2nd")
	for i in range(pcount):
		words.append("3rd")
	for i in range(pcount):
		words.append("4th")
func _characterSelectedMessage(charname):
	get_node("announcer").text=("Player "+str((turnorder[counter]))+" has selected "+charname+"!")
	counter=counter+1
	if (counter==pcount*4):
		get_tree().change_scene_to_file("res://scenes/itemAssignmentMenu/itemAssignmentMenu.tscn")
	else:
		get_node("announcer").text=get_node("announcer").text+("\nPlayer "+str((turnorder[counter]))+" select your " +str(words[counter-1])+ " squadmate")
		
func _addId(id):
	if (turnorder[counter-1]==1):
		global.team0.append(id)
	elif (turnorder[counter-1]==2):
		global.team1.append(id)
	elif (turnorder[counter-1]==3):
		global.team2.append(id)
	elif (turnorder[counter-1]==4):
		global.team3.append(id)

func _on_texture_button_tim_o_brien_selected() -> void:
	_characterSelectedMessage("[color=Aqua]Tim O' Brien[/color]")
	_addId(0)

func _on_texture_button_jimmy_cross_selected() -> void:
	_characterSelectedMessage("[color=Mintcream]Jimmy Cross[/color]")
	_addId(1)


func _on_texture_button_kiowa_selected() -> void:
	_characterSelectedMessage("[color=Cornsilk]Kiowa[/color]")
	_addId(2)


func _on_texture_button_norman_bowker_selected() -> void:
	_characterSelectedMessage("[color=blue]Norman Bowker[/color]")
	_addId(3)


func _on_texture_button_mary_anne_selected() -> void:
	_characterSelectedMessage("[color=Darkgreen]Mary Anne[/color]")
	_addId(4)


func _on_texture_button_rat_kiley_selected() -> void:
	_characterSelectedMessage("[color=Gray]Rat Kiley[/color]")
	_addId(5)


func _on_texture_button_henry_dobbins_selected() -> void:
	_characterSelectedMessage("[color=Magenta]Henry Dobbins[/color]")
	_addId(6)


func _on_texture_button_linda_selected() -> void:
	_characterSelectedMessage("[color=orchid]Linda[/color]")
	_addId(7)


func _on_texture_button_gobbos_selected() -> void:
	_characterSelectedMessage("12 [color=Darkorange]Gobbos of the Deep Dark[/color]")
	_addId(8)


func _on_texture_button_grumkins_selected() -> void:
	_characterSelectedMessage("12 [color=Greenyellow]Grumkins[/color]")
	_addId(9)


func _on_texture_button_strangler_figs_selected() -> void:
	_characterSelectedMessage("12 [color=Chartreuse]Strangler Figs[/color]")
	_addId(10)


func _on_texture_button_pepperion_pigs_selected() -> void:
	_characterSelectedMessage("20 [color=pink]Pepperion Pigs[/color]")
	_addId(11)


func _on_texture_button_3_ghosts_selected() -> void:
	_characterSelectedMessage("6 [color=Thistle]Spooky Ghosts[/color]")
	_addId(12)


func _on_texture_button_3_snakes_selected() -> void:
	_characterSelectedMessage("The 14 [color=Lawngreen]Snakes[/color]")
	_addId(13)


func _on_texture_button_3_lost_medics_selected() -> void:
	_characterSelectedMessage("6 [color=Brown]Lost Medics[/color]")
	_addId(14)


func _on_texture_button_friend_selected() -> void:
	_characterSelectedMessage("4 [color=Crimson]????[/color]")
	_addId(15)
