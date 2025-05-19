extends Button


func _on_decline_button_pressed() -> void:
	self.queue_free()


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits/credits.tscn")
