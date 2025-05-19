extends TextureButton
signal kiowaSelected

func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=Cornsilk]Kiowa[/color]")
	tooltip.setDescription("Compassionate. Prayers to heal allies and melee to dismember foes. Avoid mud.")
	
	return tooltip



func _on_pressed() -> void:
	emit_signal("kiowaSelected")
	get_parent().queue_free()
