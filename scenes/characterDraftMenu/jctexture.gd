extends TextureButton
signal jimmyCrossSelected

func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=Mintcream]Jimmy Cross[/color]")
	tooltip.setDescription("A lost commander who uplifts his soldiers with speechcraft. Martyr complex.")
	
	return tooltip
	


func _on_pressed() -> void:
	emit_signal("jimmyCrossSelected")
	get_parent().queue_free()
