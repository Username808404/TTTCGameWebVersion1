extends RichTextLabel

var example_text = "Are you a conscientious objector? Or just a coward? A real American would find it the highest privelege to ACCEPT THE DRAFT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT ACCEPT. pretty please? (As if you have any free will to decline)"

func scroll_text(input_text:String):
	visible_characters =0
	text=input_text
	
	
	for i in get_parsed_text():
		visible_characters+=1
		await get_tree().create_timer(randfn(0.0,0.07)).timeout
		
		


func _on_decline_button_pressed() -> void:
	visible = true
	scroll_text(example_text)
