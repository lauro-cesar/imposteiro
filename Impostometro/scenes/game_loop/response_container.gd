extends GridContainer




func _input(event: InputEvent) -> void:
	var type = event.get_class()
	# type safety loss...
	if type in ["InputEventKey"]:
		#print(event)
		var keycode = event.keycodes
		var key_name = OS.get_keycode_string(keycode)
		
	
