extends TextureButton
signal snakesSelected
func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=Lawngreen]The Snakes[/color]")
	tooltip.setDescription("14 poison-spitting slithering things.")
	
	return tooltip
	
	


func _on_pressed() -> void:
	emit_signal("snakesSelected")
	get_parent().queue_free()
