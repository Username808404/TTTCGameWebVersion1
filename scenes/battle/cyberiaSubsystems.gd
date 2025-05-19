extends Node2D #CYBERIA SUBSYSTEMS CENTRAL CONTROL NODE 
signal tuturu
var challenger0=[] #contains IDs for left side team
var challenger1=[] #contains IDs for right side team 

var challenger0Items=[] 
var challenger1Items=[]

var countLeft=[] # contains IDs for left side, accounting for count
var countRight=[] # contains IDs for right side, accounting for count

var left=[] #contains instantiated left side team
var right=[] #contains instantiated right side team 

var countItemsLeft=[] #contains item IDs for left side, accounting for count
var countItemsRight=[] #contains item IDs for right side, accounting for count 

var leftMoveDone=false
var rightMoveDone=false

var x=-12*6+6
var y=12*5+6

var currentTurn=0

var deathRectangles=[Rect2(534,508,12,12),Rect2(27,495,12,12),Rect2(495,508,12,12),Rect2(92,508,12,12),Rect2(1,495,12,12)]
var fallen=[]

var announcerQueue=""
var queueIndex=0

var winnerFound=false
var interferenceCount=0
func _physics_process(delta: float) -> void:
	if randi_range(0,2)==1:
		_act3()
		for i in range(5):
			get_node("announcer").visible_characters=queueIndex
			if (queueIndex<=(get_node("announcer").text.length())):
				queueIndex+=1
			
func _ready():
	set_physics_process(false)
	#global.challengers=[true,true,false,false] #DELETE 24-28, only temporary 
	#global.team0=[9,9,9,9]
	#global.team1=[9,9,9,9]
	#global.team0Items=[9,9,9,9]
	#global.team1Items=[3,3,3,3]
	_loadCharacters()
	_accelaDistribution()
func _moveLeft():
	for allyCharacter in left:
		if randi_range(0,2)==1:
			allyCharacter._setMoveSpeed(allyCharacter._getMaxMoveSpeed())
			_movementPhase(allyCharacter,left,right)

func _moveRight():
	for allyCharacter in right:
		if randi_range(0,2)==1:
			allyCharacter._setMoveSpeed(allyCharacter._getMaxMoveSpeed())
			_movementPhase(allyCharacter,right,left)
func _act3(): # N E S W 
	_moveLeft()
	_moveRight()
	
	for allyCharacter in left:
		allyCharacter._setActions(allyCharacter._getMaxActions())
		_abilityPhase(allyCharacter,left,right)
	for allyCharacter in right:
		allyCharacter._setActions(allyCharacter._getMaxActions())
		_abilityPhase(allyCharacter,right,left)
	
	
	for allyCharacter in left:
		if randi_range(0,2)==1:
			_aStormofSwords(allyCharacter,right)
	for allyCharacter in right:
		if randi_range(0,2)==1:
			_aStormofSwords(allyCharacter,left)

	_aFeastForCrows()
	_causalInterference()
		
func _movementPhase(ally,allyList,enemyList):
	var movedCount=0
	if ally._getHealth()>0:
		var distanceList=[]
		var aliveEnemyList=[]
		for enemy in enemyList:
			if enemy._getHealth()>0:
				distanceList.append(ally.position.distance_to(enemy.position))
				aliveEnemyList.append(enemy)
		var minDistance=10000
		for distance in distanceList:
			if distance<minDistance:
				minDistance=distance
		var targetIndex=distanceList.find(minDistance)
		if targetIndex!=-1 and aliveEnemyList.size()>0:
			var target=aliveEnemyList[targetIndex]
			while minDistance>12*ally._getRange() and ally._getMoveSpeed()>0:
				var moveOptionDistances=[10000,10000,10000,10000]
				moveOptionDistances[0]=((ally.position+Vector2(0,-12)).distance_to(target.position)) #NORTH 
				moveOptionDistances[1]=((ally.position+Vector2(12,0)).distance_to(target.position)) #EAST
				moveOptionDistances[2]=((ally.position+Vector2(0,12)).distance_to(target.position)) #SOUTH
				moveOptionDistances[3]=((ally.position+Vector2(-12,0)).distance_to(target.position)) #WEST
				for ally2 in allyList: #Checks if new positions aren't colliding with ally positions
					if ally2._getHealth()>0 and ally2!=ally:
						if ((ally.position+Vector2(0,-12)).distance_to(ally2.position))<=11:
							moveOptionDistances[0]=10000
						if ((ally.position+Vector2(12,0)).distance_to(ally2.position))<=11:
							moveOptionDistances[1]=10000
						if ((ally.position+Vector2(0,12)).distance_to(ally2.position))<=11:
							moveOptionDistances[2]=10000
						if ((ally.position+Vector2(-12,0)).distance_to(ally2.position))<=11:
							moveOptionDistances[3]=10000
				for enemy2 in enemyList: #checks if new positions aren't colliding with enemy positions 
					if ((ally.position+Vector2(0,-12)).distance_to(enemy2.position))<=11:
						moveOptionDistances[0]=10000
					if ((ally.position+Vector2(12,0)).distance_to(enemy2.position))<=11:
						moveOptionDistances[1]=10000
					if ((ally.position+Vector2(0,12)).distance_to(enemy2.position))<=11:
						moveOptionDistances[2]=10000
					if ((ally.position+Vector2(-12,0)).distance_to(enemy2.position))<=11:
						moveOptionDistances[3]=10000
						
				for newDistance in moveOptionDistances:
					if newDistance<minDistance:
						minDistance=newDistance
				var direction=moveOptionDistances.find(minDistance)
				if moveOptionDistances[0]+moveOptionDistances[1]+moveOptionDistances[2]+moveOptionDistances[3]==40000:
					ally._setMoveSpeed(ally._getMoveSpeed()-1)
					ally.set_process(false)
				else:
					if randi_range(1,10)>9:
						var badShow=[0,2]
						var madDirection=badShow[randi_range(0,1)]
						if moveOptionDistances[madDirection]!=10000:
							direction=madDirection
					if direction==0 and ally._getHealth()>0:
						ally._wanDance(ally.position+Vector2(0,-12))
					elif direction==1 and ally._getHealth()>0:
						ally._wanDance(ally.position+Vector2(12,0)) 
					elif direction==2 and ally._getHealth()>0:
						ally._wanDance(ally.position+Vector2(0,12))
					elif direction==3 and ally._getHealth()>0:
						ally._wanDance(ally.position+Vector2(-12,0))
					#await get_tree().create_timer(randf_range(0.4,1.3)).timeout
					movedCount+=1
				ally._setMoveSpeed(ally._getMoveSpeed()-1)
	if movedCount>0 and randi_range(0,(10*(countLeft.size()+countRight.size())))==0:
		get_node("announcer").text+=global._moved(ally._getName(),movedCount)
		for i in range(randi_range(4,9)):
			get_node("announcer").text+=" "

func _abilityPhase(ally,allyList,enemyList):
	var healedTargets=0
	var healPotential=0
	var medicFound=false
	if ally._getAbilityList().find("medic3")!=-1:
		medicFound=true
		healedTargets=3
		healPotential=100 
	if ally._getAbilityList().find("medic2")!=-1:
		medicFound=true
		healedTargets=2
		healPotential=50 
	if ally._getAbilityList().find("medic1")!=-1:
		medicFound=true
		healedTargets=1 
		healPotential=25
	if medicFound:
		for i in range(healedTargets):
			if (randi_range(0,6)==1):
				var x=randi_range(0,allyList.size()-1)
				if allyList[x]._getHealth()<allyList[x]._getMaxHealth():
					var beginHealth=allyList[x]._getHealth()
					allyList[x]._setHealth(allyList[x]._getHealth()+randi_range(1,healPotential))
					if (allyList[x]._getHealth()>allyList[x]._getMaxHealth()):
						allyList[x]._setHealth(allyList[x]._getMaxHealth())
					var endHealth=allyList[x]._getHealth()
					if randi_range(0,5)==0:
						get_node("announcer").text+=ally._getName()+" healed " + allyList[x]._getName() + " for [color=green] " + str(endHealth-beginHealth) + "[/color] [color=green]health![/color]"
						for i2 in range(randi_range(4,8)):
							get_node("announcer").text+=" "
	if ally._getAbilityList().find("summonSnake")!=-1:
		ally._setAbilityList([])
		get_node("announcer").text+=ally._getName()+" brings in some pet [color=Lawngreen]Snakes[/color]!    "
		var tav=preload("res://scenes/characterList/snakes.tscn")
		for i in range(5):
			var instance=tav.instantiate()
			instance.global_position=Vector2(randi_range(0,300),randi_range(100,200))
			add_child(instance)
			allyList.append(instance)
func _aStormofSwords(ally,enemyList):
	var distanceList=[]
	var aliveEnemyList=[]
	for enemy in enemyList:
		if enemy._getHealth()>0:
			distanceList.append(ally.position.distance_to(enemy.position))
			aliveEnemyList.append(enemy)
	var minDistance=10000
	for distance in distanceList:
		if distance<minDistance:
			minDistance=distance
	var targetIndex=distanceList.find(minDistance)
	if targetIndex!=-1 and aliveEnemyList.size()>0 and ally._getHealth()>0:
		var target=aliveEnemyList[targetIndex]
		var bonus=0
		if ally._getRange()==1:
			bonus=6
		while (ally.position.distance_to(target.position))<=bonus+(12*ally._getRange()) and ally._getActions()>0:
			if randi_range(0,ally._getSpeed())>randi_range(0,target._getDodge()) and target._getHealth()>0:
				var damage
				var tav
				if ally._getActions()==ally._getMaxActions() and randi_range(0,3)==1:
					if ally._getRange()>1:
						if randi_range(0,1)==1:
							tav=preload("res://scenes/characterList/arrow.tscn")
						elif ally._getMagAtk()>0:
							tav=preload("res://scenes/characterList/magicBolt.tscn")
						else:
							tav=preload("res://scenes/characterList/bullet.tscn")
					else:
						tav=preload("res://scenes/characterList/slash.tscn")
					var instance=tav.instantiate()
					instance.global_position=ally.position
					add_child(instance)
					instance.look_at(target.position)
					instance._wanDance(target.position)
				if ally._getMagAtk()>0.5*ally._getPhysAtk():
					damage=randi_range(0,ally._getMagAtk())
					target._setHealth(target._getHealth()-damage)
				else:
					damage=randi_range(0,ally._getPhysAtk())
					if damage>=target._getArmor():
						target._setHealth(target._getHealth()-(damage-target._getArmor()))
						target._setArmor(0)
					else:
						target._setArmor(target._getArmor()-damage)
				if randi_range(0,2*(countLeft.size()+countRight.size()))==0 and damage>0 and randi_range(0,1)==1:
					get_node("announcer").text+=global._hitOther(ally._getName(),target._getName(),damage)
					for time in range(randi_range(5,8)):
						get_node("announcer").text+=" "
			ally._setActions(ally._getActions()-1)
		if target._getHealth()<0:
			target._setHealth(0)
		
var index=0
func _accelaDistribution():
	for character in left:
		_distributeItems(character,countLeft,countItemsLeft)
	index=0
	for character in right:
		_distributeItems(character,countRight,countItemsRight)
	emit_signal("tuturu")
	
func _distributeItems(i,countIDList,countItemsList):
	if countIDList[index]==countItemsList[index]:
		if countIDList[index]==0:
			get_node("announcer").text+=(i._getName() + " claims the [color=gold]Cowardice of Conformity[/color]! +[color=gold]50 dodge[/color]")
			i._setDodge(i._getDodge()+50)
		elif countIDList[index]==1:
			get_node("announcer").text+=(i._getName() + " clutches the [color=lightskyblue]Prismatic Pebble[/color]! +[color=lightskyblue]50 willpower[/color]")
			i._setwillpower(i._getwillpower()+50)
		elif countIDList[index]==2:
			get_node("announcer").text+=(i._getName() + " wields the [color=silver]Sanctified Hatchet[/color]! +[color=silver]25 speed and phys. atk[/color]")
			i._setSpeed(i._getSpeed()+25)
			i._setPhysAtk(i._getPhysAtk()+25)
		elif countIDList[index]==3:
			get_node("announcer").text+=(i._getName() + " wears the [color=purple]Heart of Purple[/color]! +[color=purple]150 health[/color]")
			i._setMaxHealth(i._getMaxHealth()+800)
			i._setHealth(i._getHealth()+800)
		elif countIDList[index]==4:
			get_node("announcer").text+=(i._getName() + " breathes in the [color=lime]Wilderness[/color]! +[color=lime]10 dodge, speed, willpower, and phys. atk[/color]")
			i._setDodge(i._getDodge()+10)
			i._setSpeed(i._getSpeed()+10)
			i._setwillpower(i._getwillpower()+10)
			i._setPhysAtk(i._getPhysAtk()+10)
		elif countIDList[index]==5:
			get_node("announcer").text+=(i._getName() + " carries his [color=firebrick]Medkit[/color]! +[color=firebrick]tier III healing ability[/color]")
			i._setAbilityList(["medic3"])
		elif countIDList[index]==6:
			get_node("announcer").text+=(i._getName() + " brandishes his [color=skyblue]M-60 Machine Gun[/color]! +[color=skyblue]6 attacks per turn[/color]")
			i._setMaxActions(i._getMaxActions()+6)
		elif countIDList[index]==7:
			get_node("announcer").text+=(i._getName() + " is infused with [color=aquamarine]21 Grams of a Human Soul[/color]! +[color=aquamarine]25 dodge, willpower, and magical atk[/color]")
			i._setDodge(i._getDodge()+25)
			i._setwillpower(i._getwillpower()+25)
			i._setMagAtk(i._getMagAtk()+25)
	elif countItemsList[index]==8:
		get_node("announcer").text+=(i._getName() + " drinks [color=mistyrose]8 Seconds of Unused Time[/color]! +[color=mistyrose]3 max movement speed[/color]")
		i._setMaxMoveSpeed(i._getMaxMoveSpeed()+3)
		i._setMoveSpeed(i._getMaxMoveSpeed())
	elif countItemsList[index]==9:
		get_node("announcer").text+=(i._getName() + " purchases [color=dodgerblue]Trauma Team Health Insurance[/color]! +[color=dodgerblue]40 health[/color]")
		i._setMaxHealth(i._getMaxHealth()+40)
		i._setHealth(i._getHealth()+40)
	for time in range(randi_range(5,8)):
		get_node("announcer").text+=" "
	index+=1

func _aFeastForCrows():
	var leftHealthTotal=0
	var rightHealthTotal=0
	var winner
	for character in left:
		character._updateHealthBar(character._getHealth(),character._getMaxHealth())
		if character._getHealth()==0 and fallen.find(character)==-1:
			_burial(character)
			left.remove_at(left.find(character))
		leftHealthTotal+=character._getHealth()
	for character in right:
		character._updateHealthBar(character._getHealth(),character._getMaxHealth())
		rightHealthTotal+=character._getHealth()
		if character._getHealth()==0 and fallen.find(character)==-1:
			_burial(character)
			right.remove_at(right.find(character))
	get_node("team1Bar").value=leftHealthTotal
	get_node("team2Bar").value=rightHealthTotal
	if leftHealthTotal==0:
		if winnerFound==false:
			global.challengers[global.challengers.find(true)]=false
			winnerFound=true
		winner=global.challengers.find(true)
		get_node("winButton").visible=true
		get_node("announcer").visible=false
		get_node("winButton").text="Player " + str(winner+1) + " emerges victorious! [Return]"

	elif rightHealthTotal==0:
		winner=global.challengers.find(true)
		get_node("winButton").visible=true
		get_node("announcer").visible=false
		get_node("winButton").text="Player " + str(winner+1) + " emerges victorious! [Return]"

func _burial(deadPerson):
	deadPerson.get_child(1).set_region_rect(deathRectangles[randi_range(0,4)])
	deadPerson.z_index=0
	deadPerson.set_process(false)
	deadPerson.get_node("healthBar").visible=false
	fallen.append(deadPerson)

func _loadCharacters():
	if global.challengers[0]==true:
		if challenger0.size()==0:
			for i in global.team0:
				challenger0.append(i)
			challenger0Items=global.team0Items
		else:
			for i in global.team0:
				challenger1.append(i)
			challenger1Items=global.team0Items

	if global.challengers[1]==true:
		if challenger0.size()==0:
			for i in global.team1:
				challenger0.append(i)
			challenger0Items=global.team1Items

		else:
			for i in global.team1:
				challenger1.append(i)
			challenger1Items=global.team1Items
	
	if global.challengers[2]==true:
		if challenger0.size()==0:
			for i in global.team2:
				challenger0.append(i)
			challenger0Items=global.team2Items
		else:
			for i in global.team2:
				challenger1.append(i)
			challenger1Items=global.team2Items
				
	if global.challengers[3]==true:
		if challenger0.size()==0:
			for i in global.team3:
				challenger0.append(i)
			challenger0Items=global.team3Items
		else:
			for i in global.team3:
				challenger1.append(i)
			challenger1Items=global.team3Items
	var selectedCount=0
	for i2 in challenger0:
		var unitCount=1
		if (i2>=8 and i2<=10):
			unitCount=6
		if (i2==13):
			unitCount=7
		if (i2==11):
			unitCount=10
		if (i2==12 or i2==14):
			unitCount=3
		if (i2==15):
			unitCount=2
		for x2 in range(unitCount):
			countLeft.append(i2)
			countItemsLeft.append(challenger0Items[selectedCount])
		selectedCount+=1
			
	selectedCount=0
	for i2 in challenger1:
		var unitCount=1
		if (i2>=8 and i2<=10):
			unitCount=6
		if (i2==13):
			unitCount=7
		if (i2==11):
			unitCount=10
		if (i2==12 or i2==14):
			unitCount=3
		if (i2==15):
			unitCount=2
		for x2 in range(unitCount):
			countRight.append(i2)
			countItemsRight.append(challenger1Items[selectedCount])
		selectedCount+=1
	
	for i in countLeft:
		_anythingAnywhere(i,x,y,false,0)
		y+=12*randi_range(2,5)
		if y>22*12:
			y=12*5+6
			x+=12*2
		
	x=15*45+6
	y=12*5+6
	for i in countRight:
		_anythingAnywhere(i,x,y,true,1)
		y+=12*randi_range(2,5)
		if y>22*12:
			y=12*5+6
			x+=12*2
func _anythingAnywhere(id, x3,y3, flip, side):
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
	instance.global_position=Vector2(x3,y3)
	add_child(instance)
	if (flip==true):
		instance.get_node("Sprite2D").flip_h=!instance.get_node("Sprite2D").flip_h
	if side==0:
		left.append(instance)
	elif side==1:
		right.append(instance)

func _returnal():
	get_tree().change_scene_to_file("res://scenes/preBattleMenu/preBattleMenu.tscn")

func _on_tuturu() -> void:
	Engine.physics_jitter_fix=0.5
	Engine.time_scale=1.0
	var maxLeftHealth=0
	var maxRightHealth=0
	for leftCharacter in left:
		leftCharacter.z_index=1
		leftCharacter._setMaxHealth(leftCharacter._getMaxHealth()+(2*leftCharacter._getMaxHealth()/(leftCharacter._getCount())))
		leftCharacter._setHealth(leftCharacter._getMaxHealth())
		maxLeftHealth+=leftCharacter._getMaxHealth()
	for rightCharacter in right:
		rightCharacter.z_index=1
		rightCharacter._setMaxHealth(rightCharacter._getMaxHealth()+(2*rightCharacter._getMaxHealth()/(rightCharacter._getCount())))
		rightCharacter._setHealth(rightCharacter._getMaxHealth())
		maxRightHealth+=rightCharacter._getMaxHealth() 
	get_node("team1Bar").max_value=maxLeftHealth
	get_node("team1Bar").value=maxLeftHealth
	get_node("team2Bar").max_value=maxRightHealth
	get_node("team2Bar").value=maxRightHealth
	set_physics_process(true)
	


func _on_win_button_pressed() -> void:
	_returnal()

func _causalInterference(): #this is where I rig the dice
	if interferenceCount<6:
		if get_node("team1Bar").value/get_node("team1Bar").max_value > 1.5*(get_node("team2Bar").value/get_node("team2Bar").max_value):
			for character in right:
				if randi_range(1,3)!=3:
					character._setMaxActions(character._getMaxActions()+1)
					character._setSpeed(character._getSpeed()*1.2)
					character._setDodge(character._getDodge()*1.3)
					var percentage=character._getHealth()/character._getMaxHealth()
					character._setMaxHealth(character._getMaxHealth()*1.5)
					character._setSpeed(character._getSpeed()*1.2)
					character._setDodge(character._getDodge()*1.3)
					character._setHealth(percentage*character._getMaxHealth())
			interferenceCount+=1
		elif get_node("team2Bar").value/get_node("team2Bar").max_value > 1.5*(get_node("team1Bar").value/get_node("team1Bar").max_value):
			for character in left:
				if randi_range(1,3)!=3:
					character._setMaxActions(character._getMaxActions()+1)
					var percentage=character._getHealth()/character._getMaxHealth()
					character._setMaxHealth(character._getMaxHealth()*1.5)
					character._setHealth(percentage*character._getMaxHealth())
			interferenceCount+=1
	
