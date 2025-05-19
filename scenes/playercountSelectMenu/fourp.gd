extends Button


func _on_pressed() -> void:
	global.playerCount=4
	get_tree().change_scene_to_file("res://scenes/characterDraftMenu/characterDraftMenu.tscn")
