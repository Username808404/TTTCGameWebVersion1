extends TextureButton
signal maryAnneSelected
func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=Darkgreen]Mary Anne[/color]")
	tooltip.setDescription("A wildling jungle sprite. Occasionally shakes off snakes from her hair.
.")
	
	return tooltip
	
	


func _on_pressed() -> void:
	emit_signal("maryAnneSelected")
	get_parent().queue_free()
