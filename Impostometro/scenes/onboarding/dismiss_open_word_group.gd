extends Button


func _on_pressed() -> void:
	GlobalEventBus.emit_signal("debug_log",{"msg":"dismiss_open_word_group button clicked"})		
	GlobalEventBus.emit_signal("dismiss_open_word_group",{})	
