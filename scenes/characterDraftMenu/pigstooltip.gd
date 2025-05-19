extends TextureButton
signal pepperionPigsSelected
func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=pink]Pepperion Pigs[/color]")
	tooltip.setDescription("20 tusked boars fighting for god, gold, and glory.")
	
	return tooltip
	
	


func _on_pressed() -> void:
	emit_signal("pepperionPigsSelected")
	get_parent().queue_free()
