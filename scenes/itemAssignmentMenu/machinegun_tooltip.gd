extends TextureButton

func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=aquamarine]21 Grams of a Human Soul[/color]")
	tooltip.setDescription("Tell me, and I remain corporeal.")
	
	return tooltip
