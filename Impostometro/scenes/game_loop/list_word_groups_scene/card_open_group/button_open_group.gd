extends Button


var payload: Dictionary = {}

func load_payload(payload: Dictionary) -> void:
	pass 
	
 
func _on_pressed() -> void:
	GlobalEventBus.emit_signal("open_word_group",payload)
