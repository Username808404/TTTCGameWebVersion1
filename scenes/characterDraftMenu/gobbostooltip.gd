extends TextureButton
signal gobbosSelected
func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=Darkorange]Gobbos of the Deep Dark[/color]")
	tooltip.setDescription("A patrol of 12 green goblins come to offer mercenary aid.")
	
	return tooltip
	
	


func _on_pressed() -> void:
	emit_signal("gobbosSelected")
	get_parent().queue_free()
