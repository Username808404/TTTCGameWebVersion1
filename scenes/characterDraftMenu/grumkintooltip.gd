extends TextureButton
signal grumkinsSelected
func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=Greenyellow]Grumkins[/color]")
	tooltip.setDescription("12 grumkins with a penchant for archery. And gold.")
	
	return tooltip
	
	


func _on_pressed() -> void:
	emit_signal("grumkinsSelected")
	get_parent().queue_free()
