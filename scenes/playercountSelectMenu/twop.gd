extends Button


func _on_pressed() -> void:
	global.playerCount=2
	get_tree().change_scene_to_file("res://scenes/characterDraftMenu/characterDraftMenu.tscn")
