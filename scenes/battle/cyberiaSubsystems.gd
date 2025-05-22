extends Node2D #CYBERIA SUBSYSTEMS CENTRAL CONTROL NODE 
signal tuturu

signal fire #Ability activation signals
signal pigs
signal adrenaline
signal prayer 
signal gobbo

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
var fallenLeft=[]
var fallenRight=[]
var abilityList=[0,1,2,3,4] 

var queueIndex=0

var winnerFound=false
var interferenceCount=0
var interferenceMax=global._trueRandom()
var frameCount=0

var leftAbilityCharge=0
var rightAbilityCharge=0
var leftAbility
var rightAbility
var leftFire=false
var rightFire=false
func _physics_process(delta: float) -> void:
	if frameCount%3==0:
		_act3()
		for i in range(5):
			get_node("announcer").visible_characters=queueIndex
			if (queueIndex<=(get_node("announcer").text.length())):
				queueIndex+=1
		if frameCount%120==0 and leftAbilityCharge<10:
			leftAbilityCharge+=1
			get_node("leftAbilityButton/TextureProgressBar").value=leftAbilityCharge
		if frameCount%120==0 and rightAbilityCharge<10:
			rightAbilityCharge+=1
			get_node("rightAbilityButton/TextureProgressBar").value=rightAbilityCharge
	frameCount+=1


func _ready():
	set_physics_process(false)
	#global.challengers=[true,true,false,false] #DELETE 24-28, only temporary 
	#global.team0=[0,1,8,11]
	#global.team1=[0,1,8,11]
	#global.team0Items=[0,1,9,9]
	#global.team1Items=[0,1,9,9]
	_musicOfDragons()
	_loadCharacters()
	_accelaDistribution()
func _moveLeft():
	for allyCharacter in left:
		allyCharacter._setMoveSpeed(allyCharacter._getMaxMoveSpeed())
		_movementPhase(allyCharacter,left,right,0)

func _moveRight():
	for allyCharacter in right:
		allyCharacter._setMoveSpeed(allyCharacter._getMaxMoveSpeed())
		_movementPhase(allyCharacter,right,left,1)
func _act3(): # N E S W 
	if randi_range(0,2)<2: #OPTIMIZE
		_moveLeft()
	if randi_range(0,2)<2: #OPTIMIZE
		_moveRight()
	
	for allyCharacter in left:
		allyCharacter._setActions(allyCharacter._getMaxActions())
		_abilityPhase(allyCharacter,left,right,0)
	for allyCharacter in right:
		allyCharacter._setActions(allyCharacter._getMaxActions())
		_abilityPhase(allyCharacter,right,left,1)
	
	
	for allyCharacter in left:
		#if randi_range(0,2)<2: #OPTIMIZE
		_aStormofSwords(allyCharacter,right,0)
	for allyCharacter in right:
		#if randi_range(0,2)<2: #OPTIMIZE
		_aStormofSwords(allyCharacter,left,1)

	_aFeastForCrows()
	_causalInterference()
		
func _movementPhase(ally,allyList,enemyList,teamNumber):
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
			while ally._getMoveSpeed()>0: #minDistance>12*ally._getRange() and OPTIMIZATION
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
					if randi_range(1,10)>8:
						var badShow=randi_range(0,2)
						var madPossibilities
						if teamNumber==0:
							madPossibilities=[0,1,2]
						else:
							madPossibilities=[0,2,3]
						if moveOptionDistances[madPossibilities[badShow]]!=10000:
							direction=madPossibilities[badShow]
					if direction==0 and ally._getHealth()>0:
						ally._wanDance(ally.position+Vector2(0,-12))
					elif direction==1 and ally._getHealth()>0:
						ally._wanDance(ally.position+Vector2(12,0)) 
					elif direction==2 and ally._getHealth()>0:
						ally._wanDance(ally.position+Vector2(0,12))
					elif direction==3 and ally._getHealth()>0:
						ally._wanDance(ally.position+Vector2(-12,0))
					#await get_tree().create_timer(randf_range(0.4,1.3)).timeout
					movedCount+=randi_range(1,15)
				ally._setMoveSpeed(ally._getMoveSpeed()-10) #OPTIMIZE
	if movedCount>0 and randi_range(0,(25*(countLeft.size()+countRight.size())))==0:
		get_node("announcer").text+=global._moved(ally._getName(),movedCount)
		for i in range(randi_range(4,9)):
			get_node("announcer").text+=" "

func _abilityPhase(ally,allyList,enemyList,teamNumber):
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
			var leftHealthBar=preload("res://scenes/tooltips/teamLeftHealthBar.tscn")
			var rightHealthBar=preload("res://scenes/tooltips/teamRightHealthBar.tscn")
			var healthBar
			if teamNumber==0:
				healthBar=leftHealthBar.instantiate()
			else:
				healthBar=rightHealthBar.instantiate()
			var instance=tav.instantiate()
			instance.global_position=Vector2(randi_range(0,300),randi_range(100,200))
			add_child(instance)
			instance.add_child(healthBar)
			allyList.append(instance)
func _aStormofSwords(ally,enemyList,sideNumber):
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
						if ally._getMagAtk()>0:
							tav=preload("res://scenes/characterList/magicBolt.tscn")
						else:
							tav=preload("res://scenes/characterList/bullet.tscn")
					else:
						tav=preload("res://scenes/characterList/slash.tscn")
					if (sideNumber==0 and leftFire==true) or (sideNumber==1 and rightFire==true):
						tav=preload("res://scenes/characterList/fire.tscn")
					var instance=tav.instantiate()
					instance.position=ally.position
					instance.attackRange=ally._getRange()
					add_child(instance)
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
				if randi_range(0,4*(countLeft.size()+countRight.size()))==0 and damage>0:
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
		get_node("announcer").text+=(i._getName() + " drinks [color=mistyrose]8 Seconds of Unused Time[/color]! +[color=mistyrose]1 max action per turn[/color]")
		i._setMaxActions(i._getMaxActions()+1)
		i._setActions(i._getMaxActions())
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
	var leftMaxHealthTotal=0
	var rightMaxHealthTotal=0
	for character in left:
		character._updateHealthBar(character._getHealth(),character._getMaxHealth())
		leftHealthTotal+=character._getHealth()
		if character._getHealth()==0 and fallenLeft.find(character)==-1:
			left.remove_at(left.find(character))
			_burial(character,0)
	for character in right:
		character._updateHealthBar(character._getHealth(),character._getMaxHealth())
		rightHealthTotal+=character._getHealth()
		if character._getHealth()==0 and fallenRight.find(character)==-1:
			right.remove_at(right.find(character))
			_burial(character,1)
	for character in left:
		leftMaxHealthTotal+=character._getMaxHealth()
	for character in fallenLeft:
		leftMaxHealthTotal+=character._getMaxHealth()
	for character in right:
		rightMaxHealthTotal+=character._getMaxHealth()
	for character in fallenRight:
		rightMaxHealthTotal+=character._getMaxHealth()
	get_node("team1Bar").value=leftHealthTotal
	get_node("team1Bar").max_value=leftMaxHealthTotal
	get_node("team2Bar").value=rightHealthTotal
	get_node("team2Bar").max_value=rightMaxHealthTotal
	var winner
	if leftHealthTotal==0:
		if winnerFound==false:
			global.challengers[global.challengers.find(true)]=false
			winnerFound=true
		winner=global.challengers.find(true)
		get_node("winButton").visible=true
		get_node("announcer").visible=false
		get_node("winButton").text="Player " + str(winner+1) + " emerges victorious! [Return]"
		get_node('rightAbilityButton').visible=false
		get_node('leftAbilityButton').visible=false
	elif rightHealthTotal==0:
		winner=global.challengers.find(true)
		get_node("winButton").visible=true
		get_node("announcer").visible=false
		get_node("winButton").text="Player " + str(winner+1) + " emerges victorious! [Return]"
		get_node('rightAbilityButton').visible=false
		get_node('leftAbilityButton').visible=false
		
func _burial(deadPerson,side):
	deadPerson.get_child(1).set_region_rect(deathRectangles[randi_range(0,4)])
	deadPerson.z_index=0
	deadPerson.set_process(false)
	deadPerson.get_node("healthBar").visible=false
	if side==0:
		fallenLeft.append(deadPerson)
	elif side==1:
		fallenRight.append(deadPerson)

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
		_anythingAnywhere(i,x,y,false,0,false,-1)
		y+=12*randi_range(2,5)
		if y>22*12:
			y=12*5+6
			x+=12*2
		
	x=15*45+6
	y=12*5+6
	for i in countRight:
		_anythingAnywhere(i,x,y,true,1,false,-1)
		y+=12*randi_range(2,5)
		if y>22*12:
			y=12*5+6
			x+=12*2
func _anythingAnywhere(id, x3,y3, flip, side,abilityScale,power):
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
	var leftHealthBar=preload("res://scenes/tooltips/teamLeftHealthBar.tscn")
	var rightHealthBar=preload("res://scenes/tooltips/teamRightHealthBar.tscn")
	var healthBar
	if side==0:
		healthBar=leftHealthBar.instantiate()
	elif side==1:
		healthBar=rightHealthBar.instantiate()
	instance.z_index=1
	instance.add_child(healthBar)
	instance._setMaxHealth(instance._getMaxHealth()+(2*instance._getMaxHealth()/(instance._getCount())))
	instance._setHealth(instance._getMaxHealth())
	if abilityScale==true:
		instance.get_node("Sprite2D").scale=Vector2(2,2)
		instance.get_node("CollisionShape2D").scale=Vector2(2,2)
		instance.get_node("TextureButton").scale=Vector2(2,2)
		instance.get_node("TextureButton").position=Vector2(-12,-12)
		instance.get_node("healthBar").scale=Vector2(2,1)
		instance.get_node("healthBar").position=Vector2(-12,-15)
		if id==11:
			instance._setMaxHealth(instance._getMaxHealth()*float(1.2+float(power/10.0)))
			instance._setHealth(instance._getMaxHealth())
			instance._setSpeed(instance._getSpeed()+power+2)
			instance._setDodge(instance._getDodge()+power+2)
			instance._setName("[color=pink]Great Potbellied Boar[/color]")
		elif id==8:
			instance._setMaxHealth(instance._getMaxHealth()*float(1.2+1.2*float(power/10.0)))
			instance._setHealth(instance._getMaxHealth())
			instance._setSpeed(instance._getSpeed()+power+5)
			instance._setDodge(instance._getDodge()+power+5)
			instance._setName("[color=darkorange]Hobgobbo Elite[/color]")
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
		maxLeftHealth+=leftCharacter._getMaxHealth()
	for rightCharacter in right:
		maxRightHealth+=rightCharacter._getMaxHealth() 
	get_node("team1Bar").max_value=maxLeftHealth
	get_node("team1Bar").value=maxLeftHealth
	get_node("team2Bar").max_value=maxRightHealth
	get_node("team2Bar").value=maxRightHealth
	set_physics_process(true)
	


func _on_win_button_pressed() -> void:
	_returnal()

func _causalInterference(): #this is where I rig the dice
	if interferenceCount<interferenceMax:
		if get_node("team1Bar").value/get_node("team1Bar").max_value > 1.5*(get_node("team2Bar").value/get_node("team2Bar").max_value):
			for character in right:
				if randi_range(1,3)!=3:
					character._setPhysAtk(character._getPhysAtk()*1.3)
					character._setMagAtk(character._getMagAtk()*1.3)
					character._setSpeed(character._getSpeed()*1.3)
					var percentage=character._getHealth()/character._getMaxHealth()
			interferenceCount+=1
		elif get_node("team2Bar").value/get_node("team2Bar").max_value > 1.5*(get_node("team1Bar").value/get_node("team1Bar").max_value):
			for character in left:
				if randi_range(1,3)!=3:
					character._setPhysAtk(character._getPhysAtk()*1.3)
					character._setMagAtk(character._getMagAtk()*1.3)
					character._setSpeed(character._getSpeed()*1.3)
					var percentage=character._getHealth()/character._getMaxHealth()
			interferenceCount+=1
	
func _musicOfDragons():
	leftAbility=abilityList.pick_random()
	abilityList.remove_at(abilityList.find(leftAbility))
	rightAbility=abilityList.pick_random()
	
	var abilityTexts=["[color=Lawngreen]Hire Hobgobbos[/color]", "[color=pink]Corral Greatboars[/color]","[color=orangered]Prescribed Burn[/color]","[color=firebrick]Adrenaline[/color]","[color=gold]Foxhole Prayer[/color]"]
	get_node("leftAbilityButton/richTextLabel").text=abilityTexts[leftAbility]
	get_node("rightAbilityButton/richTextLabel").text=abilityTexts[rightAbility]

func _zoltraak(abilityID,charge,side):
	var flipOrNo
	if abilityID==1 or abilityID==0:
		if abilityID==1:
			emit_signal("pigs")
		else:
			emit_signal("gobbo")
		var unitID=[8,11][abilityID]
		var times=[3,5][abilityID]
		y=12*5+6
		if side==0:
			x=-12*6+6
			flipOrNo=false
		elif side==1:
			x=15*45+6
			flipOrNo=true
		for i in range(times):
			_anythingAnywhere(unitID,x,y,flipOrNo,side,true,charge)
			y+=12*randi_range(2,5)
			if y>22*12:
				y=12*5+6
				x+=12*2
	elif abilityID==2:
		emit_signal("fire")
		var allies=left
		if side==1:
			allies=right
			rightFire=true
		else:
			leftFire=true
		for ally in allies:
			if ally._getPhysAtk()>0:
				ally._setPhysAtk(ally._getPhysAtk()+charge)
			else:
				ally._setMagAtk(ally._getMagAtk()+charge)
		
	elif abilityID==3:
		var enemyList
		if side==0:
			enemyList=right
		else:
			enemyList=left
		for enemy in enemyList:
			enemy._setSpeed(enemy._getSpeed()-charge)
			enemy.speedForce=0.3
		emit_signal("adrenaline")
	elif abilityID==4:
		var allyList
		var tav
		if side==0:
			allyList=left
			tav=preload("res://scenes/characterList/blueCross.tscn")
		elif side==1:
			allyList=right
			tav=preload("res://scenes/characterList/redCross.tscn")
		for ally in allyList:
			ally._setMaxHealth(ally._getMaxHealth()*(1.2+float(charge/40.0)))
			ally._setHealth(ally._getHealth()+ally._getMaxHealth()*float(0.3+charge/35.0))
			if ally._getHealth()>ally._getMaxHealth():
				ally._setHealth(ally._getMaxHealth())
			var instance=tav.instantiate()
			instance.position=ally.position+Vector2(0,-200)
			instance.speedForce=10
			add_child(instance)
			instance._wanDance(ally.position)
		emit_signal("prayer")
		
func _on_left_ability_button_pressed() -> void:
	_zoltraak(leftAbility,leftAbilityCharge,0)
	leftAbilityCharge=1000
	get_node("leftAbilityButton").visible=false


func _on_right_ability_button_pressed() -> void:
	_zoltraak(rightAbility,rightAbilityCharge,1)
	rightAbilityCharge=1000
	get_node("rightAbilityButton").visible=false


func _on_fire() -> void:
	queueIndex=0
	get_node("announcer").visible_characters=0
	get_node("announcer").text="[color=orangeRed]'Let the night come alive with the music of dragons.'[/color]  \n\n "
	


func _on_pigs() -> void:
	queueIndex=0
	get_node("announcer").visible_characters=0
	get_node("announcer").text="[color=pink]'Beasts of every land and clime, / Hearken to my joyful tidings / Of the golden future time.'[/color]\n\n   "


func _on_adrenaline() -> void:
	queueIndex=0
	get_node("announcer").visible_characters=0
	get_node("announcer").text="[color=firebrick]'Time is passing so quickly. Right now, I feel like complaining to Einstein.'[/color]\n\n   "


func _on_prayer() -> void:
	queueIndex=0
	get_node("announcer").visible_characters=0
	get_node("announcer").text="[color=gold]'I would only believe in a god who could dance.'[/color]\n\n   "


func _on_gobbo() -> void:
	queueIndex=0
	get_node("announcer").visible_characters=0
	get_node("announcer").text="[color=lawngreen]'They make no beautiful things, but they make many clever ones.'[/color]\n\n   "


func _on_backbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/preBattleMenu/preBattleMenu.tscn")
