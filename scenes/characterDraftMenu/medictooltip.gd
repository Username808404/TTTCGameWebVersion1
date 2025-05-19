extends TextureButton
signal lostMedicsSelected
func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("Lost Medics")
	tooltip.setDescription("6 others, just like you.")
	
	return tooltip
	
	


func _on_pressed() -> void:
	emit_signal("lostMedicsSelected")
	get_parent().queue_free()
