extends Node2D

var counter=0
func _process(delta: float) -> void:
	get_node("Label").visible_characters=counter
	counter+=1


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/mainMenu/central_executive.tscn")
