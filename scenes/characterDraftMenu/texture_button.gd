extends TextureButton
signal timOBrienSelected

func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=Aqua]Tim O' Brien[/color]")
	tooltip.setDescription("A coward with high dodge. Throws grenades. Tells stories to cheer up allies.")
	return tooltip
	
	


func _on_pressed() -> void:
	emit_signal("timOBrienSelected")
	get_parent().queue_free()
