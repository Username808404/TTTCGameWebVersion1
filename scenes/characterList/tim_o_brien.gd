extends CharacterBody2D

var end=self.position
var start=self.position
func _ready():
	set_process(false)

func _wanDance(additiveVector):
	end=additiveVector
	set_process(true)

func _process(delta: float) -> void:
	if (self.position!=end):
		self.position=self.position.move_toward(end,delta*75*speedForce)


var maxHealth =200*20
var maxArmor = 50
var health = 200*20
var armor = 50
var charName="[color=Aqua]Tim O' Brien[/color]"

var dodge = 25 # +50 with the cowardice of conformity 
var speed = 50
var speedForce=1

var defense = 50
var willpower= 10

var physAtk = 25
var magAtk = 0

var maxMoveSpeed=2
var moveSpeed = 2

var count = 1
var atkrange = 6
var maxActions=3
var actions = 3
var team

var abilityList=["plotArmor", "grenade", "storytelling"]
var itemList=[]

func _getMaxHealth():
	return(maxHealth)
func _setMaxHealth(newMaxHealth):
	maxHealth=newMaxHealth
func _getHealth():
	return(health)
func _setHealth(newHealth):
	health=newHealth
func _getMaxArmor():
	return(maxArmor)
func _setMaxArmor(newmArmor):
	maxArmor=newmArmor
func _getArmor():
	return(armor)
func _setArmor(newArmor):
	armor=newArmor
func _getDodge():
	return(dodge)
func _setDodge(newDodge):
	dodge=newDodge
func _getSpeed():
	return(speed)
func _setSpeed(newSpeed):
	speed=newSpeed
func _getDefense():
	return(defense)
func _setDefense(newdefense):
	defense=newdefense
func _getwillpower():
	return(willpower)
func _setwillpower(newWillPower):
	willpower=newWillPower
func _getPhysAtk():
	return(physAtk)
func _setPhysAtk(newAtk):
	return(newAtk)
func _getMagAtk():
	return(magAtk)
func _setMagAtk(newMagAtk):
	magAtk=newMagAtk
func _getMaxMoveSpeed():
	return(maxMoveSpeed)
func _setMaxMoveSpeed(newMaxSpeed):
	maxMoveSpeed=newMaxSpeed
func _getMoveSpeed():
	return(moveSpeed)
func _setMoveSpeed(newMoveSpeed):
	moveSpeed=newMoveSpeed
func _getRange():
	return(atkrange)
func _setRange(newRange):
	atkrange=newRange
func _getMaxActions():
	return(maxActions)
func _setMaxActions(newMA):
	maxActions=newMA
func _getActions():
	return(actions)
func _setActions(newActionCount):
	actions=newActionCount
func _getName():
	return(charName)
func _setName(newName):
	charName=newName
func _setAbilityList(listing):
	abilityList=listing
func _getAbilityList():
	return(abilityList)
func _getCount():
	return(count)
	
func _updateHealthBar(currentHealth,maxHealth):
	get_node("healthBar").max_value=maxHealth
	get_node("healthBar").value=currentHealth
