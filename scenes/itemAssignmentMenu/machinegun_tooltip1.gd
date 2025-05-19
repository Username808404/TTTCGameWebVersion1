extends TextureButton

func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=skyblue]M-60 Machine Gun[/color]")
	tooltip.setDescription("150 kg, custom-tooled cartridges, 10k rpm")
	
	return tooltip
