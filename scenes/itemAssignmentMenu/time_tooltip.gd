extends TextureButton

func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=mistyrose]8 Seconds of Unused Time[/color]")
	tooltip.setDescription("Made from the reflections cast by rust and stardust'")
	
	return tooltip
