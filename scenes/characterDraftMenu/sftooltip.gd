extends TextureButton
signal stranglerFigsSelected
func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=Chartreuse]Strangler Fig[/color]")
	tooltip.setDescription("12 trees who awoke from their slumber and joined the ents on their march.")
	
	return tooltip
	
	


func _on_pressed() -> void:
	emit_signal("stranglerFigsSelected")
	get_parent().queue_free()
