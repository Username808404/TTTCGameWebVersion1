extends Control

func _on_pressed():
	get_tree().change_scene_to_file("res://scenes/playercountSelectMenu/playercountSelect.tscn")
	
	


	


func _on_decline_button_pressed() -> void:
	for _i in self.get_children():
		await get_tree().create_timer(randfn(0.0,1)).timeout
		_i.visible=true
		
		


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.
