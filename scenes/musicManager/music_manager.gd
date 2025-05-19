extends Node

var lotus
var papers
var chrono
func _ready():
	var lotusLandStory=preload("res://scenes/touhou_4_lotus_land_story_opening.tscn")
	var instance=lotusLandStory.instantiate()
	add_child(instance)
	instance.play()
	lotus=instance
	
	var papersPlease=preload("res://scenes/papers,please_theme_song.tscn")
	instance=papersPlease.instantiate()
	add_child(instance)
	papers=instance
	
	var chronoTrigger=preload("res://scenes/chrono_trigger_soundtrack_corridors_of_time[hq].tscn")
	instance=chronoTrigger.instantiate()
	chrono=instance

func initializePapers():
	papers.play()
	
func initializeChrono():
	chrono.play
