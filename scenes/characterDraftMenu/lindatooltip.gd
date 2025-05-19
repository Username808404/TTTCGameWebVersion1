extends TextureButton
signal lindaSelected
func _make_custom_tooltip(_for_text: String) -> Object:
	var tooltipScene: PackedScene = load("res://scenes/tooltips/tooltips.tscn")
	var tooltip: Control = tooltipScene.instantiate()
	tooltip.setName("[color=orchid]Linda[/color]")
	tooltip.setDescription("Alive, so long as you remember her.")
	
	return tooltip
	
	


func _on_pressed() -> void:
	emit_signal("lindaSelected")
	get_parent().queue_free()
