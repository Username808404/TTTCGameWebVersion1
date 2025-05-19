extends TextureButton
signal friendSelected

func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=Crimson]FRIEND[/color]")
	tooltip.setDescription("Arrived in Vietnam by crossing a long silvery string between the stars.")
	
	return tooltip
	
	


func _on_pressed() -> void:
	emit_signal("friendSelected")
	get_parent().queue_free()
