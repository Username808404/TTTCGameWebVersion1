extends Node
var playerCount
var team0=[]
var team1=[]
var team2=[]
var team3=[]
var challengers=[false,false,false,false]

var team0Items=[-1,-1,-1,-1]
var team1Items=[-1,-1,-1,-1]
var team2Items=[-1,-1,-1,-1]
var team3Items=[-1,-1,-1,-1]


var selectingTeam=0


func _moved(allyName, movetotal):
	movetotal=str("[color=yellow]"+str(movetotal)+"[/color]")
	var moveStrings=[allyName + " trudges " + str(movetotal) + " meters forward through the jungle soil!", 
	allyName + "‘s legs carry them forward " + str(movetotal) + " steps.",
	str(movetotal) +" meters are all " + allyName + " can manage.",
	allyName + "‘s body moves them " + str(movetotal) + " strides. Their mind is lost.",
	allyName + " crawls " + str(movetotal) + " paces, movements smooth as summer silk.",
	allyName + " wishes to desert, but moves " + str(movetotal) + " steps.",
	allyName + "‘s legs are leaden, but move " + str(movetotal) + " meters nonetheless.",
	allyName + " simply moves. In what direction, they don’t know.",
	allyName + " carries only themselves, and only " +str(movetotal)+ " strides.",
	str(movetotal) +". More. Steps. " +allyName+ " moves."
	]
	return(moveStrings[randi_range(0,9)])

func _hitOther(allyName, enemyName, damageDealt):
	var hitStrings=[allyName + " chomps down on " + enemyName + " [color=red]"+str(damageDealt)+"[/color][color=red] times![/color]", 
	allyName + " inflicts " +"[color=red]"+str(damageDealt)+"[/color] [color=red]damage[/color]" +" upon "+enemyName,
	allyName+ " attacks "+ enemyName + " for "+"[color=red]"+str(damageDealt)+"[/color] [color=red]damage[/color]!",
	enemyName + " loses " +"[color=red]"+str(damageDealt)+"[/color] [color=red]years of their lifespawn[/color] to " + allyName,
	]
	return(hitStrings[randi_range(0,3)])
