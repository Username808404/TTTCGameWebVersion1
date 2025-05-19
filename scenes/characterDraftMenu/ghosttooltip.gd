extends TextureButton
signal ghostsSelected
func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=Thistle]A Herd of Ghosts[/color]")
	tooltip.setDescription("6 spooky scaries from beyond, here to offer guidance.")
	
	return tooltip
	
	


func _on_pressed() -> void:
	emit_signal("ghostsSelected")
	get_parent().queue_free()
