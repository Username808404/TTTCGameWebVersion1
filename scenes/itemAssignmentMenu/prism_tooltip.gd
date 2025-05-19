extends TextureButton

func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=lightskyblue]Prismatic Pebble[/color]")
	tooltip.setDescription("It fills you with determination.")
	
	return tooltip
