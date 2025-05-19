extends VBoxContainer

func setName(text: String):
	get_node("HBoxContainer/nameLabel").text=text
	
func setDescription(text: String):
	get_node("HBoxContainer2/Label").text=text
	
