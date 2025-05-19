extends TextureButton

func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=silver]Sanctified Hatchet[/color]")
	tooltip.setDescription("Pride of the woodsman.")
	
	return tooltip
