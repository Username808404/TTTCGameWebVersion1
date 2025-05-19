extends Button



func _on_pressed() -> void:
	MusicManager.lotus.stop()
	MusicManager.initializePapers()
	self.queue_free()
	
