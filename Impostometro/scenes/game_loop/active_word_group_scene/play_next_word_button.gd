extends Button

		
func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)		

func _on_set_play_next_word_button_visibility(payload: Dictionary) -> void:
	# If group is empty, disable this button
	visible=payload.get('state', false)

func _on_pressed() -> void:
	GlobalEventBus.emit_signal("debug_log",{"msg":"Play next word button clicked"})	
	
	# load next word will emit set_play_next_word_button_visibility
	GlobalEventBus.emit_signal("load_next_word",{})

func _ready() -> void:	
	_on_register_global_signals({
		"msg":"Registrando Play next word button"
	})
	GlobalEventBus.connect("set_play_next_word_button_visibility", _on_set_play_next_word_button_visibility)
	
	
