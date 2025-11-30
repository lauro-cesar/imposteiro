extends Button



func _on_pressed() -> void:
	GlobalEventBus.emit_signal("debug_log",{"msg":"Play active word button clicked"})	
	GlobalEventBus.emit_signal("play_active_word",{})


func _on_register_global_signals(payload: Dictionary) -> void:
	GlobalEventBus.emit_signal("debug_log",payload)	
	
	if not GlobalEventBus.has_user_signal("set_play_active_word_button_visibility"):
		GlobalEventBus.add_user_signal("set_play_active_word_button_visibility", [{ "name": "payload", "type": Variant.Type.TYPE_DICTIONARY }])

func _on_set_play_active_word_button_visibility(payload: Dictionary) -> void:
	# If group is empty, disable this button
	visible=payload.get('state', false)
	
func _ready() -> void:
	#visible=false
	_on_register_global_signals({
		"msg":"Registrando Play active word button"
	})
	GlobalEventBus.connect("set_play_active_word_button_visibility", _on_set_play_active_word_button_visibility)
	
	
