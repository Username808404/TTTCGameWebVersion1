extends TextureButton
signal normanBowkerSelected
func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=blue]Norman Bowker[/color]")
	tooltip.setDescription("Your standard issue soldier. Avoid circles.")
	
	return tooltip
	
	


func _on_pressed() -> void:
	emit_signal("normanBowkerSelected")
	get_parent().queue_free()
