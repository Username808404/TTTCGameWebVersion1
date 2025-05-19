extends TextureButton
signal ratKileySelected
func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=Gray]Rat Kiley[/color]")
	tooltip.setDescription("The night is dark and full of terrors. Medicine, morphine, and M&Ms.")
	
	return tooltip
	
	


func _on_pressed() -> void:
	emit_signal("ratKileySelected")
	get_parent().queue_free()
