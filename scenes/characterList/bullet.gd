extends CharacterBody2D #projectile, not an actual CHARACTER 
var maxHealth = 0
var maxArmor = 0
var health = 0
var armor = 0
var speedForce=175 #DELTA
var charName="[color=Crimson]FRIEND[/color]"
var end=self.position
var start=self.position
var attackRange=2
var opening=false
var randomNess=false
func _ready():
	set_process(false)
	if randomNess==true:
		if get_node("Sprite2D")!=null:
			get_node("Sprite2D").region_rect=Rect2(677+13*randi_range(0,20),287+13*randi_range(0,4),12,12)
func _wanDance(additiveVector):
	if opening==true:
		speedForce=10
	end=additiveVector
	self.look_at(end)
	set_process(true)
	await get_tree().create_timer(randf_range(0,0.6)).timeout
	self.queue_free()
func _process(delta: float) -> void:
	if (self.position!=end):
		if attackRange>1 and randi_range(0,2)==1:
			if end.x>self.position.x and end.y-self.position.y<=12: #AHEAD TO RIGHT
				end.x=end.x+randi_range(250,750)
				end.y=end.y+randi_range(-200,200)
				speedForce=randi_range(450,550)
			elif end.x<self.position.x and end.y-self.position.y<=12: #AHEAD TO LEFT
				end.x=end.x-randi_range(250,750)
				speedForce=randi_range(450,550)
				end.y=end.y+randi_range(-200,200)
			elif end.x-self.position.x<=12 and end.y>self.position.y:
				end.y=end.y+randi_range(250,750)
				end.x=end.x+randi_range(-200,200)
				speedForce=randi_range(450,550)
			elif end.x-self.position.x<=12:
				end.y=end.y-randi_range(250,750)

		self.look_at(end)
		if opening==false:
			self.position=self.position.move_toward(end,delta*speedForce)
		else:
			self.velocity=end
			self.move_and_slide()

var dodge = 50
var speed = 50

var defense = 15
var willpower= 40 

var physAtk = 0 
var magAtk = 20

var maxMoveSpeed=4
var moveSpeed = 2
var count = 2
var atkrange = 8
var actions = 3
var maxActions=3
var team

var abilityList=["medic2"]
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
	
